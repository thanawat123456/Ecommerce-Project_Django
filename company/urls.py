from django.urls import path
from .views import *



urlpatterns = [
    path('', Home,name = 'home-page'), #name = 'home-page' เป็นการตั้งชื่อเล่น  
    path('about/',About,name = 'about-page'), #about/ คือชื่อของหน้าเว็บไซต์ของหน้านั้น
    path('contact/',Contact, name = 'contact-page'),
    path('addproduct/',AddProduct, name='addproduct-page'),
    path('allproduct/',Product,name='allproduct-page'),
    path('register/',Register, name='register-page'),
    path('addtocart/<str:pid>/',AddCart,name='addtocart-page'),
    #path('addtocart/id=<int:pid>/',AddCart,name='addtocart-page'),
    path('mycart/',MyCart,name='mycart-page'),
    path('mycart/edit', MyCartEdit, name='mycartedit-page'),
    path('checkout/',Checkout, name='checkout-page'),
    path('orderlist/',OrderListPage,name='orderlist-page'),
    path('allorderlist/',AllOrderListPage,name='allorderlist-page'),
    path('uploadslip/<str:orderid>/',UploadSlip, name='uploadslip-page'),
    path('updatestatus/<str:orderid>/<str:status>/',Updatepaid, name='updatestatus'),
    path('updatetracking/<str:orderid>/',UpdataTracking,name='updatetracking'),
    path('myorder/<str:orderid>/',MyOrder,name='myorder-page'),
    path('category/<int:code>/',ProductCategory,name='category-page'),
    path('testmd/',TestMD,name='testmd-page'),
    path('product/<str:productid>/',ProductDetail,name='detail-page'),
    path('editproduct/<str:productid>/',EditProduct,name='editproduct-page'),
    path('testhome/',Testhome,name = 'test-page'),
    path('t/',t,name = 'test-page')
    

]
