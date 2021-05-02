#!/usr/bin/python

import smtplib

sender = 'noreply@rajeskarnena.me'
receivers = ['rajesh.karnena@gmail.com']

message = """From: noreply@rajeskarnena.me
To: rajesh.karnena@gmail.com
Subject: SMTP e-mail test

This is a test e-mail message.
"""


smtpObj = smtplib.SMTP('smtp.dev.rajeshkarnena.me', 25)
smtpObj.login('admin', 'password')
smtpObj.sendmail(sender, receivers, message) 
print "Successfully sent email"
