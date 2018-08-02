#!/usr/bin/perl

#The SHA1 perl module is the library responsible for creating the SHA1
#digital signature.
use Digest::SHA1;

#Declares the sendmail program that will be used to send an email after 
#the response is recieved from the Realex Gateway. You may have to change 
#this depending on your system ot use an alternative way to send an email.
$sendmail = '/bin/sendmail -t';

# Parse the data sent to this file
&parseForm();

# Replace these with the values you receive from Realex Payments. If you do not have
# these values please contact Realex Payments.
$merchantid = "yourMerchantId";
$secret = "yourSecret";  

#Note:>
# The below code is used to grab the fields Realex Payments POSTs back 
# to this script after a card has been authorised. Realex Payments need
# to know the full URL of this script in order to POST the data back to this
# script. Please inform Realex Payments of this URL if they do not have it 
# already.
$timestamp = $f{TIMESTAMP};
$merchantid = $f{MERCHANT_ID};
$orderid = $f{ORDER_ID};
$result = $f{RESULT};
$message = $f{MESSAGE};
$pasref = $f{PASREF};
$authcode = $f{AUTHCODE};

# any other fields you passed to Realex Payments will be 
# available here too - we simply pass them straight back
# to your response cgi script. eg:
#
# $customernumber = $f{"custnum"};
# $phonenumber = $f{"phone"};
#
# (ie - these were also in the form that was submitted to Realex Payments)


#Below is the code for creating the digital signature using the SHA1 
#algorithm. The function is in the Digest::SHA1 library that is referenced
#at the top of this file.
$sha1 = Digest::SHA1->new;
$tmp = "$timestamp.$merchantid.$orderid.$result.$message.$pasref.$authcode";
$sha1->add($tmp);
$sha1hash = $sha1->hexdigest;
$tmp = "$sha1hash.$secret";
$sha1->add($tmp);
$sha1hash = $sha1->hexdigest;

print "Content-type: text/html\n\n";

#This digital signature should correspond to the one Realex Payments POSTs back to
#this script and can therefore be used to verify the message Realex sends back.
#Check that the hash we return to you is correct
#If not then a message is printed and the program exits.

if ($sha1hash ne $f{SHA1HASH}) {
	print "Error authenticating response";
	exit(0);
}

# "00" means a successful transaction - anything else is 
# an error of some type - either with the details the customer
# entered or with the setup of your account.
#
# 
#IMPORTANT: Whatever this response script prints is grabbed by Realex Payments
#and placed in the template again. It is placed wherever the comment <hpp:body/>
#is in the template you provide. This is the case so that from a customer's perspective, they are not suddenly removed from 
#a secure site to an unsecure site. This means that although we call this response script the 
#customer is still on Realex Payemnt's site and therefore it is recommended that a HTML link is
#printed in order to redirect the customrer back to the merchants site.

if ($result ne "00") {
	print <<EOM;
	We're sorry, we could not process your order at this time. Your card
	has not been charged. 
	Please contact our customer care department at <a href="mailto:custcare@yourdomain.com">
       <b><u>custcare@yourdomain.com</u></b></a>or if you would prefer to subscribe by phone, 
       call on 01 2839428349
	
        NOTE: This link should bring the customer back to a place where an new orderid is<br>
	created so that they can try to use another card/payment method. It is important that a new orderid<BR>
	is created because if the same orderid is sent in a second time Realex Payments will
	reject it as a duplicate order even if the first transaction was declined.<BR>";
EOM
	
} else {
	print "Thank you - your order (number $orderid) has been accepted.";
}

#In this example a mail is sent to the relevant person, be it the customer or the merchant
#to inform them of an order taking place. This example uses the sendmail facility.The path to the program is 
#defined at the start of the script. Feel free to use the one that bests suits you and to change the format of the mail. The below is just
#an example.

$reply =<<EOM;

The following order was been submitted for payment:

OrderID: $orderid

The result was

Result: $result
Message: $message

Authcode (if any): $authcode
PAS Ref: $pasref


EOM

open (MAIL, "| $sendmail");

print MAIL <<EOM;
From: customer\@customer.com
To: you\@you.com
Subject: Order from website: ID $orderid

$reply

EOM

close MAIL;



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
#of the Realex Payments payment solution service in accordance with the
#written instructions of an authorised representative of Realex Payments.
#Any other use is strictly prohibited.

