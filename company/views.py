from django.shortcuts import render ,redirect
from django.http import HttpResponse
from .models import *
from datetime import datetime 
from django.core.paginator import Paginator
from jango.models import Sessions
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from django.core.files.storage import FileSystemStorage
import markdown as md
from django.contrib.auth.decorators import login_required



############################
def CheckAdmin(request):
    if request.user.profile.usertype != "admin":
        return redirect('home-page')
    return






##############Email#################
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

#sendthai('thanawat.sai@kkumail.com',subject,msg)

# หากต้องการส่งหลายคนสามารถใส่คอมม่าใน string ได้เลย เช่น 'loongTu1@gmail.com,loongTu2@gmail.com'


'''
-------------------------
ตั้งค่าให้เป็นสีเขียวก่อนส่ง แล้วลองรีเฟรชดู ( on )
https://myaccount.google.com/lesssecureapps
'''

####################################


def Home(request):
    
    product = AllProduct.objects.all().order_by('id').reverse()[:6] #เป็นการดึงข้อมูลมาจาก model เป็นฐานข้อมูล ดึงข้อมูลมาทั้งหมด
    preorder = AllProduct.objects.filter(quantity__lte=0)
    #quantity__lte = 0  (หาค่าที่ quantity <= o - lte is <=) underscore 2 ตัว
    #quantity__gt = 0 (หาค่าที่ quantity > 0 - gt is >)
    #quantity__gte = 5 (หาค่าที่ quantity >= 5 - gte is >=)
    context = {'product': product,'preorder': preorder}


    
    return render(request,'myapp/home2.html',context) #request ต้องใส่เพื่อร้องขอ
     #return HttpResponse('<h1>Hello World!</h1> <br> <p>by thanawat saiyota</p>')
     
 
def About(request):
    return render(request,'myapp/about.html',)

def Testhome(request):
    product = AllProduct.objects.all().order_by('id').reverse() #เป็นการดึงข้อมูลมาจาก model เป็นฐานข้อมูล โึงข้อมูลมาทั้งหมด
    paginator = Paginator(product,6) # 1 page show 6 รายการ
    page = request.GET.get('page') #http://localhost:8000/allproduct/?page=
    product = paginator.get_page(page)
    context = {'product': product}
    return render(request,'myapp/testhome.html',context)



def Contact(request):
    return render(request,'myapp/contact.html',)

def t(request):
    return render(request,'myapp/t.html',)    





def AddProduct(request):
    
    if request.user.profile.usertype != "admin":
        return redirect('home-page')

    category = Category.objects.all()

    if request.method =='POST': #ดึงข้อมูลจากหน้า html
       data =request.POST.copy()
       pid = data.get('id')
       name = data.get('name')
       price = data.get('price')
       detail = data.get('detail')
       quantity = data.get('quantity')
       unit = data.get('unit')
       cat = data.get('category')
       cat = Category.objects.get(catname=cat)
       instock = data.get('instock')
     
       new = AllProduct()
       new.id = pid
       new.name = name
       new.price = price
       new.detail = detail
       new.quantity = quantity
       new.unit = unit
       new.catname = cat
       ########### Save Image ############
       try:
           file_image = request.FILES['image']
           file_image_name = request.FILES['image'].name.replace(' ','')
           
           print('FILE_IMAGE:',file_image)
           print('IMAGE_NAME:',file_image_name)

           fs = FileSystemStorage()
           filename =fs.save(file_image_name,file_image)
           upload_file_url  = fs.url(filename)
           new.image = upload_file_url[6:] #[6:] แก้บัคตอนเพิ่มรูป
 
       except:
           new.image = '/default.png'  #หากไม่มีการอัพโหลดจะดึงภาพ default มาใช้งาน
       #######################
       new.save()
    context = {'category':category}
    return render(request,'myapp/addproduct.html',context)
    


def Product(request):
    product = AllProduct.objects.all().order_by('id').reverse() #เป็นการดึงข้อมูลมาจาก model เป็นฐานข้อมูล โึงข้อมูลมาทั้งหมด
    paginator = Paginator(product,6) # 1 page show 6 รายการ
    page = request.GET.get('page') #http://localhost:8000/allproduct/?page=
    product = paginator.get_page(page)
    context = {'product': product}

    return render(request,'myapp/allproduct.html',context)

def ProductCategory(request,code):
    select = Category.objects.get(id=code)
    product = AllProduct.objects.filter(catname=select).order_by('id').reverse() #เป็นการดึงข้อมูลมาจาก model เป็นฐานข้อมูล โึงข้อมูลมาทั้งหมด
    paginator = Paginator(product,6) # 1 page show 6 รายการ
    page = request.GET.get('page') #http://localhost:8000/allproduct/?page=
    product = paginator.get_page(page)
    context = {'product': product,'catname':select.catname}

    return render(request,'myapp/allproductcat.html',context)    



def Register(request):  
    if request.method == 'POST':
        data = request.POST.copy()
        first_name = data.get('first_name')
        last_name = data.get('last_name')
        email = data.get('email')
        password = data.get('password')
         
        newuser = User()
        newuser.username = email
        newuser.email = email
        newuser.first_name = first_name
        newuser.last_name = last_name
        newuser.set_password(password)
        newuser.save()

        ####send email fro verify ##### testing
        sendthai(email,subject,msg)



        profile = Profile()
        profile.user = User.objects.get(username=email)
        profile.save()

        user = authenticate(username=email,password=password)
        login(request,user)

    return render(request,'myapp/register.html')   


def AddCart(request,pid):
    #localhost:8000/addtocart/3
    #{% url 'addtocart-page' pd.id %}
    
    if request.user.username  == '':
           return redirect('register-page')
    username = request.user.username
    user = User.objects.get(username=username)
    check =AllProduct.objects.get(id=pid)
    



    try:  
        
        
        #กรณีที่สินค้ามีซ้ำให้บวกเพิ่มไปเรื่อยๆ
        newcart = Sessions.objects.get(user=user,productid=str(pid))
        newquan = newcart.quantity + 1
        newcart.quantity = newquan
        calculate = newcart.price * newquan
        newcart.total  = calculate
        newcart.save() 

        #อัพเดตจำนวนสินค้าทั้งหมดล่าสุดในตระกร้า
        count = Sessions.objects.filter(user=user)
        count = sum([c.quantity for c in count])
        updatequan = Profile.objects.get(user=user)
        updatequan.cartquan =count
        updatequan.save()

  
        return redirect('allproduct-page')


    except:
       

        newcart = Sessions()
        newcart.user = user
        newcart.productid= pid
        newcart.productidname = check.name
        newcart.price = int(check.price)
        newcart.quantity = 1 
        caculate = int(check.price)*1
        newcart.total = caculate
        newcart.save()

        count = Sessions.objects.filter(user=user)
        count = sum([c.quantity for c in count])
        updatequan = Profile.objects.get(user=user)
        updatequan.cartquan = count
      
        updatequan.save()
        return redirect('allproduct-page')


def MyCart(request):
    username = request.user.username
    user = User.objects.get(username=username)
    context = {}
    if request.method == 'POST':
       #ใช้สำหรับการลบเท่านั้น
       data = request.POST.copy()
       productid = data.get('productid')
       print('PID',productid)
       item = Sessions.objects.get(user=user,productid=productid)
       item.delete()
       context['status'] = 'delete'

       count = Sessions.objects.filter(user=user)
       count = sum([ c.quantity for c in count])
       updatequan = Profile.objects.get(user=user)
       updatequan.cartquan = count
       updatequan.save()

    mycart = Sessions.objects.filter(user=user)
    context['mycart'] = mycart
    count = sum([c.quantity for c in mycart])
    total = sum([c.total for c in mycart])

    context['mycart'] = mycart
    context['count'] = count
    context['total'] = total

    return render(request,'myapp/mycart.html',context)



def MyCartEdit(request):
    username = request.user.username
   
    user = User.objects.get(username=username)
    context = {}

    if request.method == 'POST':
       data = request.POST.copy()
       if data.get('clear') == 'clear':  
           Sessions.objects.filter(user=user).delete()
           updatequan = Profile.objects.get(user=user)
           updatequan.cartquan = 0  
           updatequan.save()
           return redirect('mycart-page')
       print(data) 
       editlist = []

       for k,v in data.items():  
           print([k,v])
           if k[:2] == 'pd':   
               pid = str(k.split('_')[1])
               dt = [pid,int(v)]
               editlist.append(dt)
       print('EDITLIST:',editlist)


       for ed in editlist:  
            edit = Sessions.objects.get(productid=ed[0],user=user)
            edit.quantity = ed[1]
            calculate = edit.price * ed[1]
            edit.total = calculate
            edit.save()    

       count = Sessions.objects.filter(user=user)
       count = sum([c.quantity for c in count])
       updatequan = Profile.objects.get(user=user)
       updatequan.cartquan = count     
       
       updatequan.save()  

            
       return redirect('mycart-page')

    mycart = Sessions.objects.filter(user=user)
    context['mycart'] = mycart

    return render(request,'myapp/MyCartedit.html',context)

def Checkout(request):  
    username = request.user.username
    user = User.objects.get(username=username)

    if request.method == 'POST':  
        data = request.POST.copy()
        name = data.get('name')
        tel = data.get('tel')
        address = data.get('address')
        shipping = data.get('shipping')
        payment = data.get('payment')
        other = data.get('other')
        page = data.get('page')

        if page == 'information':  
            context = {}
            context['name'] = name
            context['tel'] = tel
            context['address'] = address
            context['shipping'] = shipping
            context['payment'] = payment
            context['other'] = other

            mycart = Sessions.objects.filter(user=user)
            count = sum(c.quantity for c in mycart)
            total = sum([c.total for c in mycart])
            
            


            context['mycart'] = mycart
            context['count'] = count
            context['total'] = total
           

            



            return render(request,'myapp/checkout2.html',context)

        if page == 'confirm':
            mycart = Sessions.objects.filter(user=user)
            
            mid = str(user.id).zfill(4)
            dt = datetime.now().strftime('%Y%m%d%H%M%S')
            orderid = 'OD' + mid+dt
            dt2 =datetime.now()
            
            odp = Order()
            odp.orderid = orderid
            odp.user = user           
            odp.name = name
            odp.tel = tel
            odp.stamp = dt2
            odp.address = address
            odp.shipping = shipping
            odp.payment = payment
            odp.other = other
            odp.save()

            for pd in mycart:  
                order = OrderList()

                order2 = odp.orderid
                od = Order.objects.get(orderid = order2)
                pid =  AllProduct.objects.get(id=pd.productid)
                order.orderid = od
                order.user = user               
                order.productid = pid
                order.quantity= pd.quantity
                order.total = pd.total
                order.save()

                content2 = {

                    'orderid' : order.orderid
 

                }

            Sessions.objects.filter(user=user).delete()
            updatequan = Profile.objects.get(user=user)
            updatequan.cartquan = 0 
            updatequan.save()



           
            return redirect('mycart-page')






    return render(request,'myapp/checkout1.html') 


def OrderListPage(request):  
    username = request.user.username
    user = User.objects.get(username=username)
    context = {}
    
    order = Order.objects.filter(user=user) #คนนี้สั่งอะำรมาบ้าง

    '''
         -order
            -orderid: 0D34348
            -user:
            -name: ผู้รับ

    '''
    for od in order:   
        orderid = od.orderid  
        odlist = OrderList.objects.filter(orderid=orderid)
        '''
         -order
          -object(1)
            -orderid: 0D34348
            -product: ทึเรียน
            -total: 400
          -object(2)
            -oderid: D345234
            -product: ส้ม
            -total: 300
          -object(3)
            -orderid: E34323
            -product: กล้วย
            -total: 200  

        '''

        total = sum([c.total for c in odlist]) 
        #sum = sum([400,300,200])
        od.total = total
        
        count = sum([ c.quantity for c in odlist])
        #สั่งนับว่า order นี้มีจำนวนกี่ชิ้น

        if od.shipping == 'ems':  
           shipcost = sum([50 if i == 0 else 10 for i in range(count)])   

        else:
           shipcost = sum([30 if i == 0 else 10 for i in range(count)])      


        if od.payment == 'cod':   
           shipcost += 20  

        od.shipcost = shipcost   

    context['allorder'] = order  
    return render(request,'myapp/orderlist.html',context)








def AllOrderListPage(request):   
    context= {}
    order = Order.objects.all()

    for od in order:  
        orderid = od.orderid
        odlist = OrderList.objects.filter(orderid=orderid)
        total = sum([c.total for c in odlist])
        od.total = total

        count = sum([ c.quantity for c in odlist])
        #สั่งนับว่า order นี้มีจำนวนกี่ชิ้น

        if od.shipping == 'ems':  
           shipcost = sum([50 if i == 0 else 10 for i in range(count)])   

        else:
           shipcost = sum([30 if i == 0 else 10 for i in range(count)])      


        if od.payment == 'cod':   
           shipcost += 20  

        od.shipcost = shipcost   

    paginator = Paginator(order,5)
    page = request.GET.get('page')
    order= paginator.get_page(page)
    context['allorder'] = order 
    
    return render(request,'myapp/allorderlist.html',context)




def UploadSlip(request,orderid):   
    
    if request.method == 'POST' and request.FILES['slip']:
       data = request.POST.copy()
       sliptime = data.get('sliptime')

       update = Order.objects.get(orderid=orderid)
       update.sliptime = sliptime

       file_image = request.FILES['slip']
       file_image_name = request.FILES['slip'].name.replace(' ','')
       fs = FileSystemStorage()
       filename = fs.save(file_image_name,file_image)
       upload_file_url = fs.url(filename)
       update.slip = upload_file_url[6:]
       update.save()

    odlist = OrderList.objects.filter(orderid=orderid)
    total = sum([c.total for c in odlist])
    oddetail = Order.objects.get(orderid=orderid)
    count = sum([ c.quantity for c in odlist])

    if oddetail.shipping == 'ems':  
       shipcost = sum([50 if i == 0 else 10 for i in range(count)])   
       # shipcost = รวมค่าทั้งหมด (หากเป็นชิ้นแรกค่าส่งจะคิด 50 บาท ชิ้นถัดไปชิ้นละ 10) 
    
    else:
       shipcost = sum([30 if i == 0 else 10 for i in range(count)])      


    if oddetail.payment == 'cod':   
       shipcost += 20  


    context = {'orderid': orderid,
               'count':count,
               'total':total,
               'shipcost':shipcost,
               'grandtotal':total+shipcost,  
               'oddetail':oddetail}

    return render(request,'myapp/uploadslip.html',context)           

def Updatepaid(request,orderid,status):  
    
    if request.user.profile.usertype != "admin":
        return redirect('home-page')

    order = Order.objects.get(orderid=orderid)

    if status == 'confirm':
        order.paid = True
        order.confirmed = True
        odlist = OrderList.objects.filter(orderid=orderid)
        for od in odlist:
            product = AllProduct.objects.get(id=od.productid)
            product.quantity = product.quantity - od.quantity
            product.save()


    elif status == 'cancel':
        order.paid = False
        order.confirmed = False
    order.save()        

    return redirect('allorderlist-page')


def UpdataTracking(request,orderid):  

    if request.user.profile.usertype != "admin":
        return redirect('home-page')

    if request.method == 'POST':
        order = Order.objects.get(orderid=orderid)
        data = request.POST.copy()
        trackingnumber = data.get('trackingnumber')
        order.trackingnumber = trackingnumber
        order.save()
        return redirect('allorderlist-page')

    order = Order.objects.get(orderid=orderid)
    odlist = OrderList.objects.filter(orderid=orderid)
    
    #shipcost calculate
    total = sum([c.total for c in odlist])
    order.total = total

    count = sum([ c.quantity for c in odlist])
    #สั่งนับว่า order นี้มีจำนวนกี่ชิ้น

    if order.shipping == 'ems':  
       shipcost = sum([50 if i == 0 else 10 for i in range(count)])   

    else:
       shipcost = sum([30 if i == 0 else 10 for i in range(count)])      


    if order.payment == 'cod':   
       shipcost += 20  

    order.shipcost = shipcost     

    context = {'orderid':orderid,'order':order,'odlist':odlist,'total':total,'count':count}  


        

    return render(request,'myapp/updatetracking.html',context) 


def MyOrder(request,orderid):
    username = request.user.username
    user = User.objects.get(username=username)
   

    order = Order.objects.get(orderid=orderid)
    #เช็คว่าเป็นของตัวเองมั้ย
    if user != order.user:
        return redirect('allproduct-page')


    odlist = OrderList.objects.filter(orderid=orderid)
    
    #shipcost calculate
    total = sum([c.total for c in odlist])
    order.total = total

    count = sum([ c.quantity for c in odlist])
    #สั่งนับว่า order นี้มีจำนวนกี่ชิ้น

    if order.shipping == 'ems':  
       shipcost = sum([50 if i == 0 else 10 for i in range(count)])   

    else:
       shipcost = sum([30 if i == 0 else 10 for i in range(count)])      


    if order.payment == 'cod':   
       shipcost += 20  

    order.shipcost = shipcost 

    context = {'order':order,'odlist':odlist,'total':total,'count':count} #ดึงก้อน order,odlist เข้ามาใส่ใน context

    return render(request,'myapp/myorder.html',context) 

    ''' -order
          -object(1)
            -orderid: 0D34348
            -product: ทึเรียน
            -total: 400
          -object(2)
            -oderid: D345234
            -product: ส้ม
            -total: 300
          -object(3)
            -orderid: E34323
            -product: กล้วย
            -total: 200  

     '''



def ProductDetail(request,productid):
    product = AllProduct.objects.get(id=productid) 
    context = {'product':product}
    return render(request,'myapp/productdetail.html',context)


@login_required
def EditProduct(request,productid):
    check = CheckAdmin(request)
    print('CHECK:',check)
    if check:
        return redirect('home-page')

    product = AllProduct.objects.get(id=productid)
    category = Category.objects.all()    


    if request.method =='POST': #ดึงข้อมูลจากหน้า html
       data =request.POST.copy()
       name = data.get('name')
       price = data.get('price')
       detail = data.get('detail')
       quantity = data.get('quantity')
       unit = data.get('unit')
       cat = data.get('category')
       cat = Category.objects.get(catname=cat)  # ไม่งั้นจะเซฟไม่ได้ เนื่องจากเป็นฟอเรนคีย์
       instock = data.get('instock')
 
       product.name = name
       product.price = price
       product.detail = detail
       product.quantity = quantity
       product.unit = unit
       product.catname = cat
       
       if instock == 'instock_true':
          product.instock = True
       else:
          product.instock = False 

       print('FILES',request.FILES)
       ########### Save Image ############
       if 'image' in request.FILES:
           file_image = request.FILES['image']
           file_image_name = request.FILES['image'].name.replace(' ','')
           
           print('FILE_IMAGE:',file_image)
           print('IMAGE_NAME:',file_image_name)

           fs = FileSystemStorage()
           filename =fs.save(file_image_name,file_image)
           upload_file_url  = fs.url(filename)
           product.image = upload_file_url[6:] #[6:] แก้บัคตอนเพิ่มรูป
       else :
           print('NO')
          
       product.save()

    product = AllProduct.objects.get(id=productid) 
    context = {'product':product,'category':category}
    return render(request,'myapp/editproduct.html',context)    

























def TestMD(request):
    text = '''ลักษณะเชอรี่: กลม ผิวเรียบ สีแดงเข้ม-ดำ เงา
    #รสชาติ: หวานอมเปรี๊ยว
    - เนื้อ: นิ่ม-แดง
    แหล่งที่มา:  ประเทศแคนาดา'''
    md.markdown(text, extensions=['markdown.extensions.fenced_code'])
    context = {'text':text}
    return render(request , 'myapp/testmd.html',context)













                


















