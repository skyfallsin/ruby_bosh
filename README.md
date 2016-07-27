# RubyBosh

The RubyBOSH library handles creating and pre-authenticating BOSH streams inside your Ruby application before passing them off to your template engine. 

This method allows you to hide authentication details for your users' XMPP accounts.  

Tested on Rails 4.2, Ruby 2.1.2 with eJabberd 16.04

## References

BOSH: http://xmpp.org/extensions/xep-0124.html

XMPP via BOSH: http://xmpp.org/extensions/xep-0206.html

## Example

In your Ruby app controller (or equivalent):

```ruby
@session_jid, @session_id, @session_random_id = 
  RubyBOSH.initialize_session("me@jabber.org", "my_password", "http://localhost:5280/http-bind")
```

If you want to define your own resource name, include it within the jid.  RubyBOSH will create a random one if none is supplied.
To define a resource name of 'home', do the following:

```ruby
@session_jid, @session_id, @session_random_id = 
  RubyBOSH.initialize_session("me@jabber.org/home", "my_password", "http://localhost:5280/http-bind")
```

In your template, you would then pass these directly to your javascript BOSH connector:

``` erb
var bosh_jid = '<%= @session_jid %>';
var bosh_sid = '<%= @session_id %>';
var bosh_rid = '<%= @session_random_id %>';
```

``` js
// using Strophe:
connect.attach(bosh_jid, bosh_sid, bosh_rid, onConnectHandlerFunction);

// using ConverseJS:
converse.initialize({
        jid: bosh_jid, sid: bosh_sid, rid: bosh_rid
        // ... the rest of the initialization data
  })
```

## Acknowledgements

Jack Moffit - thanks for the [nice Django example](http://metajack.im/2008/10/03/getting-attached-to-strophe/)

Copyright (c) 2008 Pradeep Elankumaran. See LICENSE for details.

Copyright (c) 2016 Mike Polischuk. See LICENSE for details.
