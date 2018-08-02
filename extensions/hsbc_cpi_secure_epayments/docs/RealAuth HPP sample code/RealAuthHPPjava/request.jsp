<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.util.Calendar" %>


<html>
<head>
<title>Realex Payments HPP - JSP Sample Code - Request Script</title>

<%!

// Function to construct the timestamp in the correct format for Realex Payments    
public String getTimestamp() {
	String timestamp;
	Calendar now = Calendar.getInstance();
		
	timestamp = "" + now.get(Calendar.YEAR);

	if ((now.get(Calendar.MONTH) + 1) < 10) {
		timestamp += "0" + (now.get(Calendar.MONTH) + 1);
	} else {
		timestamp += "" + (now.get(Calendar.MONTH) + 1);
	}

	if (now.get(Calendar.DAY_OF_MONTH) < 10) {
		timestamp += "0" + now.get(Calendar.DAY_OF_MONTH);
	} else {
		timestamp += "" + now.get(Calendar.DAY_OF_MONTH);
	}

	if (now.get(Calendar.HOUR_OF_DAY) < 10) {
		timestamp += "0" + now.get(Calendar.HOUR_OF_DAY);
	} else {
		timestamp += "" + now.get(Calendar.HOUR_OF_DAY);
	}

	if (now.get(Calendar.MINUTE) < 10) {
		timestamp += "0" + now.get(Calendar.MINUTE);
	} else {
		timestamp += "" + now.get(Calendar.MINUTE);
	}

	if (now.get(Calendar.SECOND) < 10) {
		timestamp += "0" + now.get(Calendar.SECOND);
	} else {
		timestamp += "" + now.get(Calendar.SECOND);
	}
		
	return timestamp;
}

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

// Replace these with the values you receive from Realex Payments
merchantid = "yourMerchantId";
secret = "yourSecret";

// Replace these with the values you want to use
orderid = "Order" + timestamp;
curr = "EUR";
amount = "3000";

// Constructing the SHA1 hash to send in the POST
String testString = timestamp + "." + merchantid + "." + orderid + "." + 
	amount + "." + curr;
String testStringHashed = calcSHA1(testString);
testString = testStringHashed + "." + secret;
testStringHashed = calcSHA1(testString);

String sha1hash = testStringHashed;

%>
	
</head>

<body bgcolor="#FFFFFF">

<!--
https://hpp.realexpayments.com/pay is the script where the hidden fields
for LIVE transactions are POSTed to.

If the merchant is in TEST mode, the script to post the hidden fields to is:
https://hpp.sandbox.realexpayments.com/pay

The values are sent to Realex Payments via hidden fields in a HTML form POST.
Please look at the documentation to show all the possible hidden fields you
can send to Realex Payments.

Note: 
The more data you send to Realex Payments the more details will be available
on our reporting tool, Real Control, for the merchant to view and pull reports 
down from.

Note:
If you POST data in hidden fields that are not a Realex hidden field that data 
will be POSTed back directly to your response script. This way you can maintain
data even when you are redirected away from your site
-->

<form action=https://hpp.sandbox.realexpayments.com/pay method=post>

<input type=hidden name="MERCHANT_ID" value="<%=merchantid%>">
<input type=hidden name="ORDER_ID" value="<%=orderid%>">
<input type=hidden name="CURRENCY" value="<%=curr%>">
<input type=hidden name="AMOUNT" value="<%=amount%>">
<input type=hidden name="TIMESTAMP" value="<%=timestamp%>">
<input type=hidden name="SHA1HASH" value="<%=sha1hash%>">
<input type=hidden name="AUTO_SETTLE_FLAG" value="1">

<input type=submit value="Proceed to secure server">
</form>

<font face=verdana>
<font size=3><b>Realex Payments HPP - JSP Sample Code</b></font>
<p>
<font size=2>Select View/Source to see the output
<ul>
<li>In the example I use the date/time as the order id - you may have your own scheme.
<li>You should replace <code>merchantid</code> and <code>secret</code> with the values provided by payandshop.com
</ul>
</font>

</body>
</html>

<%
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
written instructions of an authorised representative of Pay and Shop
Limited. Any other use is strictly prohibited.

*/
%>

