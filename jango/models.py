from django.db import models
from django.contrib.auth.models import User
# Create your models here.

class Sessions(models.Model):  
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    productid = models.CharField(max_length=100)
    productidname = models.CharField(max_length=100)
    price = models.IntegerField()
    quantity = models.IntegerField()
    total = models.IntegerField()
    stamp = models.DateTimeField(auto_now_add=True,blank=True,null=True)
