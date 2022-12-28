from django.db import models
from django.contrib.auth.models import User



class Profile(models.Model):
      user = models.OneToOneField(User,on_delete = models.CASCADE)
      photo = models.ImageField(upload_to='photoprofile',null=True,blank=True,default='default.png')
      usertype = models.CharField(max_length=100,default='member')
      cartquan = models.IntegerField(default=0)
      def __str__(self):
        return self.user.first_name

class Category(models.Model):
    catname = models.CharField(max_length=200,default='สินค้าทั่วไป')
    detail = models.TextField(null=True,blank=True)
    def __str__(self):
        return self.catname
    

class AllProduct(models.Model):
    id =  models.CharField(max_length=100,primary_key=True,default='P01')
    catname = models.ForeignKey(Category,on_delete=models.CASCADE,null=True,blank=True)
    name = models.CharField(max_length= 100)
    price = models.CharField(max_length=100)
    detail = models.TextField(null=True,blank=True)
    instock = models.BooleanField(default=True)
    quantity = models.IntegerField(default=1)
    unit = models.CharField(max_length=200,default='-')
    image = models.ImageField(upload_to="products",null=True,blank=True,default='default-image.png')

    def __str__(self):
        return self.name

    def __str__(self):
        return str(self.id)



class Order(models.Model):  
    orderid =  models.CharField(max_length=100,primary_key=True)
    user = models.ForeignKey(User,on_delete=models.CASCADE,null=True,blank=True)
    name = models.CharField(max_length=100)
    tel = models.CharField(max_length=100)
    address = models.TextField()
    shipping = models.CharField(max_length=100)
    payment = models.CharField(max_length=100)
    other = models.TextField(blank=True,null=True)
    stamp = models.DateTimeField(auto_now_add=True,blank=True,null=True)
    paid = models.BooleanField(default=False)
    confirmed = models.BooleanField(default=False)
    slip = models.ImageField(upload_to="slip",null=True,blank=True)
    sliptime = models.CharField(max_length=100,null=True,blank=True)
    trackingnumber = models.CharField(max_length=100)

    def __str__(self):
        return str(self.orderid)


class OrderList(models.Model):  
    orderid = models.ForeignKey(Order,on_delete=models.CASCADE,null=True,blank=True)
    productid = models.ForeignKey(AllProduct,on_delete=models.CASCADE,null=True,blank=True)
    quantity = models.IntegerField()
    total = models.IntegerField()


    def __str__(self):
        return str(self.orderid)


