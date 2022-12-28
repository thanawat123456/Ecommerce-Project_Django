#################ส่งเมลล์ภาษาไทย########################
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

def sendthai(sendto,subj="ทดสอบส่งเมลลล์",detail="สวัสดี!\nคุณสบายดีไหม?\n"):

	myemail = 'test.django50@gmail.com'
	mypassword = '0652709145'
	receiver = sendto

	msg = MIMEMultipart('alternative')
	msg['Subject'] = subj
	msg['From'] = 'Esso Uncle Fruit'
	msg['To'] = receiver
	text = detail

	part1 = MIMEText(text, 'plain')
	msg.attach(part1)

	s = smtplib.SMTP('smtp.gmail.com:587')
	s.ehlo()
	s.starttls()

	s.login(myemail, mypassword)
	s.sendmail(myemail, receiver.split(','), msg.as_string())
	s.quit()


###########Start sending#############
subject = 'ยืนยันการสมัครเว็บไซต์ซื้อผลไม้ Esso Fruit'


namemember = 'สมชาย'
content = '''
เนื่องจากความปลอดภัยของการเข้าใช้
กรุณายืนยันอีเมลล์ ผ่านลิ้งค์ด้านล่างนี้
'''

link = 'http://esso-engineer.com/confirm/skldjfiwefkl'

msg = 'สวัสดีคุณ {} \n\n {}\n Verify Link: {}'.format(namemember,content,link)

sendthai('thanawat.sai@kkumail.com',subject,msg)

# หากต้องการส่งหลายคนสามารถใส่คอมม่าใน string ได้เลย เช่น 'loongTu1@gmail.com,loongTu2@gmail.com'


'''
-------------------------
ตั้งค่าให้เป็นสีเขียวก่อนส่ง แล้วลองรีเฟรชดู ( on )
https://myaccount.google.com/lesssecureapps
'''
