require 'rest_client'
require 'builder'
require 'rexml/document'
require 'base64'
require 'hpricot'

# based on
# http://code.stanziq.com/svn/strophe/trunk/strophejs/examples/attach/boshclient.py
class RubyBOSHClient
  BOSH_XMLNS    = 'http://jabber.org/protocol/httpbind'
  TLS_XMLNS     = 'urn:ietf:params:xml:ns:xmpp-tls'
  SASL_XMLNS    = 'urn:ietf:params:xml:ns:xmpp-sasl'
  BIND_XMLNS    = 'urn:ietf:params:xml:ns:xmpp-bind'
  SESSION_XMLNS = 'urn:ietf:params:xml:ns:xmpp-session'

  attr_accessor :jid, :rid, :sid, :success
  def initialize(jid, pw, service_url) 
    @service_url = service_url
    @jid, @pw = jid, pw
    @host = jid.split("@").last
    @success = false
    @headers = {"Content-Type" => "text/xml; charset=utf-8",
                "Accept" => "text/xml"}
    connect
  end

  def connect
    initialize_bosh_session
    if send_auth_request 
      send_restart_request
      request_resource_binding
      @success = send_session_request
    end

    if @success
      @rid+=1 #send this directly to the browser
    end
  end
  
  def initialize_bosh_session 
    response = deliver(construct_body(:wait => 5, :to => @host,
                                      :hold => 3, :window => 5,
                                      "xmpp:version" => '1.0'))
    parse(response)
  end

  def construct_body(params={}, &block)
    @rid ? @rid+=1 : @rid=rand(100000)

    builder = Builder::XmlMarkup.new
    parameters = {:rid => @rid, :xmlns => BOSH_XMLNS}.merge(params)

    if block_given?
      builder.body(parameters) {|body| yield(body)}
    else
      builder.body(parameters)
    end
  end

  def send_auth_request 
    request = construct_body(:sid => @sid) do |body|
      auth_string = "#{@jid}\x00#{@jid.split("@").first.strip}\x00#{@pw}" 
      body.auth(Base64.encode64(auth_string).gsub(/\s/,''), 
                    :xmlns => SASL_XMLNS, :mechanism => 'PLAIN')
    end

    response = deliver(request)
    # TODO: make the following more robust
    response.include?("success")
  end

  def send_restart_request
    request = construct_body(:sid => @sid, "xmpp:restart" => true, "xmlns:xmpp" => 'urn:xmpp:xbosh')
    deliver(request).include?("stream:features")
  end

  def request_resource_binding
    request = construct_body(:sid => @sid) do |body|
      body.iq(:id => "bind_#{rand(100000)}", :type => "set", 
              :xmlns => "jabber:client") do |iq|
        iq.bind(:xmlns => BIND_XMLNS) do |bind|
          bind.resource('presently')
        end
      end
    end
    
    response = deliver(request)
    response.include?("<jid>") 
  end

  def send_session_request
    request = construct_body(:sid => @sid) do |body|
      body.iq(:xmlns => "jabber:client", :type => "set",
              :id => "sess_#{rand(100000)}") do |iq|
        iq.session(:xmlns => SESSION_XMLNS)
      end 
    end

    response = deliver(request)
    response.include?("body") 
  end

  def parse(_response)
    doc = Hpricot(_response)
    doc.search("//body").each do |body|
      @sid = body.attributes["sid"].to_s
    end
    _response
  end

  def success?
    success == true
  end

  private
  def deliver(xml)
    send(xml)
    recv(RestClient.post(@service_url, xml, @headers))
  end

  def send(msg)
    puts "Ruby-BOSH - SEND\n#{msg}"; msg
  end

  def recv(msg)
    puts "Ruby-BOSH - RECV\n#{msg}"; msg
  end
end


class RubyBOSH
  def self.initialize_session(jid, pw, service_url)
    conn = RubyBOSHClient.new(jid, pw, service_url)
    if conn.success?
      [conn.jid, conn.sid, conn.rid]
    else
      [nil, nil, nil]
    end
  end
end

if __FILE__ == $0
  p RubyBOSH.initialize_session("skyfallsin@localhost", "skyfallsin", 
      "http://localhost:5280/http-bind")
end
