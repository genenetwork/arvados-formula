# frozen_string_literal: true

websocket_stanza = <<-WEBSOCKET_STANZA
      Websocket:
        ExternalURL: wss://ws.example.net/websocket
        InternalURLs:
          "http://localhost:8005": {}
WEBSOCKET_STANZA

control 'arvados configuration' do
  title 'should match desired websocket lines'

  describe file('/etc/arvados/config.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
    # We're testing it in the API instance, so group will be nginx's
    it { should be_grouped_into 'www-data' }
    its('mode') { should cmp '0640' }
    its('content') do
      should include(
        'File managed by Salt at <salt://arvados/files/default/config.tmpl.jinja>.'
      )
    end
    its('content') { should include(websocket_stanza) }
  end
end
