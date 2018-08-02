<%@ page import="java.security.MessageDigest" %>
<%!

// SHA1 hashing algorithm
public String calcSHA1(String toBeHashed) {
	byte[] digestValue = new byte[0];	
   	StringBuffer sb = new StringBuffer();
	MessageDigest md;

	try {
		md = MessageDigest.getInstance("SHA");
		md.update(toBeHashed.getBytes());
		digestValue = md.digest();

   		for (int i = 0; i < digestValue.length; i++) {
       		String c = Integer.toHexString(digestValue[i]);
       		if (digestValue[i] < 0) c = c.substring(6);
       		if (c.length() < 2) c = "0" + c;
       		sb.append(c);
    	}

	} catch (Exception e) { e.printStackTrace(); }
	
	return sb.toString();
}


%>
<%

// Get form fields passed in from the form submission 
String timestamp = request.getParameter("TIMESTAMP"); 
String merchantid = request.getParameter("MERCHANT_ID"); 
String result = request.getParameter("RESULT"); 
String order_id = request.getParameter("ORDER_ID"); 
String message = request.getParameter("MESSAGE"); 
String authcode = request.getParameter("AUTHCODE"); 
String pasref = request.getParameter("PASREF"); 
String sha1hash = request.getParameter("SHA1HASH"); 

/*
If you are enabled for DCC, these additional fields will also be posted to your response script

String merchantamount = request.getParameter("DCCAUTHMERCHANTAMOUNT");
String merchantcurrency = request.getParameter("DCCAUTHMERCHANTCURRENCY");
String cardholderamount = request.getParameter("DCCAUTHCARDHOLDERAMOUNT");
String cardholdercurrency = request.getParameter("DCCAUTHCARDHOLDERCURRENCY");
String cardholderrate = request.getParameter("DCCAUTHRATE");
String dccrate = request.getParameter("DCCAUTHRATE");
String dccchoice = request.getParameter("DCCCHOICE");
*/

// everything else  you sent through us (like the customer's email and address
// etc is also available here - so you can do something like this:
//
// String email = request.getParameter("cust-email"); 
// String address1 = request.getParameter("cust-address1"); 
//
// or whatever....

// Now update your database or send an email or whatever you need to do....
// .....

// Replace this with the secret you receive from Realex Payments. If you have not yet received this please contact us.
String secret = "secret";

// check the hash is ok - this ensures that the reply came from Realex Payments
String testString = timestamp + "." + merchantid + "." + order_id + "." + 
	result + "." + message + "." + pasref + "." + authcode;
String testStringHashed = calcSHA1(testString);
testString = testStringHashed + "." + secret;
testStringHashed = calcSHA1(testString);

if (sha1hash.compareTo(testStringHashed) != 0) {
// the hashes don't match
%>
There has been an error validating the response from our payment provider. 
Please contact us on 01 4723434 to obtain the status of your order.
<%
// you should probably send an email to a technical person here. Or an admin 
// type person. Then check with us.

} else {
// the hashes were ok - the response came from payandshop.com
	
if (result.compareTo("00") == 0) {
// the payment succeeded.
%> 

Thank You - Your payment has been accepted. If you have any enquiries 
about the order please use this order number: <br>
<% =order_id %>
<br><br>
To continue please <a href="http://yourdomain.com">click here</a>

<%
} else {
// there was a problem processing the payment. Generally it's not 
// recommended that you say what the problem was - just say there has
// been a problem and give them a customer services number or email to contact.

%>
We're sorry - there has been a problem processing your order. Please call
01 63748234 and quote your order number as: <% =order_id %>
<br>
Your credit card has not been charged. To continue browsing please 
<a href="http://yourdomain.com">click here</a>

<%
} // end of the result if-else

} // end of the hashes if-else

/*

Pay and Shop Limited (Realex Payments) - Licence Agreement.
© Copyright and zero Warranty Notice.


Merchants and their internet, call centre, and wireless application
developers (either in-house or externally appointed partners and
commercial organisations) may access Realex Payments technical
references, application programming interfaces (APIs) and other sample
code and software ("Programs") either free of charge from
www.realexpayments.com or by emailing info@realexpayments.com. 

Realex Payments provides the programs "as is" without any warranty of
any kind, either expressed or implied, including, but not limited to,
the implied warranties of merchantability and fitness for a particular
purpose. The entire risk as to the quality and performance of the
programs is with the merchant and/or the application development
company involved. Should the programs prove defective, the merchant
and/or the application development company assumes the cost of all
necessary servicing, repair or correction.

Copyright remains with Realex Payments, and as such any copyright
notices in the code are not to be removed. The software is provided as
sample code to assist internet, wireless and call center application
development companies integrate with the Realex Payments service.

Any Programs licensed by Realex Payments to merchants or developers are
licensed on a non-exclusive basis solely for the purpose of availing
of the Realex Payments service in accordance with the
written instructions of an authorised representative of Realex Payments. 
Any other use is strictly prohibited.

*/
%>


