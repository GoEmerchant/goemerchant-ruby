=begin
* This program is used to connect to the XML gateway API.
* Each request can be altered by you to test the API and
* validate the responses you receive back.
*
* Connecting to the gateway in this example is 
* done through Net::HTTP
* See: http://ruby-doc.org/stdlib-2.0/libdoc/net/http/rdoc/Net/HTTP.html 
=end

require 'net/http'

url = URI.parse('https://secure.goemerchant.com/secure/gateway/xmlgateway.aspx')

request = Net::HTTP::Post.new(URI.encode(url.path))
request.content_type = 'text/html'
request.body = 
<<-eos
<TRANSACTION>
<FIELDS>
<FIELD KEY="transaction_center_id">1264</FIELD>
<FIELD KEY="gateway_id">a91c38c3-7d7f-4d29-acc7-927b4dca0dbe</FIELD> 
<FIELD KEY="operation_type">sale</FIELD>
<FIELD KEY="order_id">YOURID_NUMBER</FIELD>
<FIELD KEY="total">5.00</FIELD>
<FIELD KEY="card_name">Visa</FIELD>
<FIELD KEY="card_number">4111111111111111</FIELD>
<FIELD KEY="card_exp">1113</FIELD>
<FIELD KEY="cvv2">123</FIELD>
<FIELD KEY="owner_name">Bob Auth</FIELD>
<FIELD KEY="owner_street">123 Test St</FIELD>
<FIELD KEY="owner_city">city</FIELD>
<FIELD KEY="owner_state">PA</FIELD>
<FIELD KEY="owner_zip">12345-6789</FIELD>
<FIELD KEY="owner_country">US</FIELD>
<FIELD KEY="recurring">0</FIELD>
<FIELD KEY="recurring_type">annually</FIELD>
</FIELDS> 
</TRANSACTION>
eos

response = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https') {|http| http.request(request)}

puts response.code
puts response.message
puts response.body