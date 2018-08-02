#!/usr/bin/perl

#The SHA1 perl module is the library responsible for creating the SHA1
#digital signature.
use Digest::SHA1;

#The parseForm function is used to parse and extract the form data
&parseForm();

# replace these with the values you receive from Realex Payments
$merchantid = "yourMerchantId";
$secret = "yourSecret";

# Replace this with the order id you want to use. The order id 
# must be unique. In the example below a combination of the timestamp
# and a random number is used. 
$orderid = abs($$)."-".time."-robin";

#In this example these values are hardcoded. In reality you may pass 
#these values from another script or take it from a database. 
$currency = $f{CURRENCY};
$amount = $f{AMOUNT};

#The below code calls the getDateTime function.This function creates 
#the timestamp in the  format required by Realex Payments .
$timestamp = &getDateTime();

#Below is the code for creating the digital signature using the SHA1 
#algorithm. The function is in the Digest::SHA1 library that is referenced
#at the top of this file.
$sha1 = Digest::SHA1->new;
$tmp = "$timestamp.$merchantid.$orderid.$amount.$currency";
$sha1->add($tmp);
$sha1hash = $sha1->hexdigest;
$tmp = "$sha1hash.$secret";
$sha1->add($tmp);
$sha1hash = $sha1->hexdigest;

print "Content-type: text/html\n\n";
print <<EOM;
<html>
<head>
<title>Realex Payments HPP - Sample Order Form (Perl)</title>
</head>

<body bgcolor="#FFFFFF">

<font face=verdana>
<font size=3><b>Realex Payments HPP - Sample Order Form (Perl)</b></font>
<p>
<font size=2>Select View/Source to see the output
<ul>
<li>In the example I use the date/time and the process id as the order id - you may have your own scheme.
<li>You should replace <code>\$merchantid</code> and <code>\$secret</code> with the values provided by Realex Payments
</ul>

Please confirm the following details. If anything is incorrect please press the back button on your browser to correct it.
<p>
    <table width="400" border="0" cellspacing="1" cellpadding="0">
      <tr> 
        <td> 
          <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Name:&nbsp;</b></font></div>
        </td>
        <td> 
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">$f{name}</font>
        </td>
      </tr>
      <tr> 
        <td> 
          <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Address:&nbsp;</b></font></div>
        </td>
        <td> 
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">$f{address}</font>
        </td>
      </tr>
      <tr> 
        <td> 
          <div align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Telephone:&nbsp;</b></font></div>
        </td>
        <td> 
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">$f{telephone}</font>
        </td>
      </tr>
      <tr> 
        <td> 
          <p align="right"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><b>Email:&nbsp;</b></font></p>
        </td>
        <td> 
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">$f{email}</font>
        </td>
      </tr>
</table>
</font>

<!--
https://hpp.realexpayments.com/pay is the script where the hidden fields
for LIVE transactions are POSTed to.

If the merchant is in TEST mode, the script to post the hidden fields to is:
https://hpp.sandbox.realexpayments.com/pay

The values are sent to Realex Payments via hidden fields in a HTML form POST.
Please look at the documentation to show all the possible hidden fields you
can send to Realex Payments.

Note:> 
The more data you send to Realex Payments the more details will be available
on our reporting tool, realControl, for the merchant to view and pull reports 
down from.

Note:>
If you POST data in hidden fields that are not a Realex hidden field that data 
will be POSTed back directly to your response script. This way you can maintain
data even when you are redirected away from your site

-->


<form action=https://hpp.sandbox.realexpayments.com/pay method=post>

<input type=hidden name=MERCHANT_ID value="$merchantid">
<input type=hidden name=ORDER_ID value="$orderid">
<input type=hidden name=TIMESTAMP value="$timestamp">
<input type=hidden name=CURRENCY value="$currency">
<input type=hidden name=AMOUNT value="$amount">
<input type=hidden name=SHA1HASH value="$sha1hash">
<input type=hidden name=AUTO_SETTLE_FLAG value="1">

<input type=submit value="Proceed to secure server">
</form>

<p>
<b>Realex Payments HPP - Sample Order Form (Perl)</b><br>

You can add the text here which you would like the customer to view before redirecting to
the Realex Payments card entry page.
</p>
</body>
</html>


EOM

#function that returns the timestamp in the format required by Realex Payments. 
sub getDateTime {
    $theDate = localtime;

    $theDate =~ s/(\s)+/ /g;

    ($day, $month, $date, $time, $year) = split(/ /, $theDate);

    $num{Jan} = "01";
    $num{Feb} = "02";
    $num{Mar} = "03";
    $num{Apr} = "04";
    $num{May} = "05";
    $num{Jun} = "06";
    $num{Jul} = "07";
    $num{Aug} = "08";
    $num{Sep} = "09";
    $num{Oct} = "10";
    $num{Nov} = "11";
    $num{Dec} = "12";

    ($hour, $min, $sec) = split(/:/, $time);

    if ($date < 10) {
    	$isoDateFormat = "$year$num{$month}0$date$hour$min$sec";
    } else {
        $isoDateFormat = "$year$num{$month}$date$hour$min$sec";
    }

    return $isoDateFormat;
}

#function that parses data POSTed or GETed to this script from ENV vars
sub parseForm {

$cl=$ENV{CONTENT_LENGTH};
$qs=$ENV{QUERY_STRING};
$error=read(STDIN,$input,$cl);
@inlist=split(/&/,$input);
@qslist=split(/&/,$qs);

foreach $item (@inlist) {
	($field,$value)=split(/=/,$item);
	$f{$field}=$value;
	$f{$field}=~ s/\+/ /g;
	$f{$field} =~ s/%([0-9A-F][0-9A-F])/sprintf("%c",hex($1))/eg;
}

foreach $item (@qslist) {
	($field,$value)=split(/=/,$item);
	$q{$field}=$value;
	$q{$field}=~ s/\+/ /g;
	$q{$field} =~ s/%([0-9A-F][0-9A-F])/sprintf("%c",hex($1))/eg;
}

}

#Pay and Shop Limited (Realex Payments) - Licence Agreement.
#© Copyright and zero Warranty Notice.
#
#
#Merchants and their internet, call centre, and wireless application
#developers (either in-house or externally appointed partners and
#commercial organisations) may access Realex Payments technical
#references, application programming interfaces (APIs) and other sample
#code and software ("Programs") either free of charge from
#www.realexpayments.com or by emailing info@realexpayments.com. 
#
#Realex Payments provides the programs "as is" without any warranty of
#any kind, either expressed or implied, including, but not limited to,
#the implied warranties of merchantability and fitness for a particular
#purpose. The entire risk as to the quality and performance of the
#programs is with the merchant and/or the application development
#company involved. Should the programs prove defective, the merchant
#and/or the application development company assumes the cost of all
#necessary servicing, repair or correction.
#
#Copyright remains with Realex Payments, and as such any copyright
#notices in the code are not to be removed. The software is provided as
#sample code to assist internet, wireless and call center application
#development companies integrate with the Realex Payments service.
#
#Any Programs licensed by Realex Payments to merchants or developers are
#licensed on a non-exclusive basis solely for the purpose of availing
#of the Realex Payment payment solution service in accordance with the
#written instructions of an authorised representative of Realex Payments.
#Any other use is strictly prohibited.
