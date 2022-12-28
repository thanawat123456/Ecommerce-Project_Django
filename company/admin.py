from django.contrib import admin
from .models import *


admin.site.site_header = 'Benjauniform'
admin.site.index_title = 'Main Admin'
admin.site.site_title = 'Benjauniform Backend'

class AllproductAdmin(admin.ModelAdmin):  
	list_display = ['name','id','instock','price','quantity']
	list_editable = ['instock','price','quantity']


admin.site.register(AllProduct,AllproductAdmin)
admin.site.register(Profile)
admin.site.register(Category)


class OrderListAdmin(admin.ModelAdmin):  
	list_display = ['orderid','productid','total']

class OrderListAdmin2(admin.ModelAdmin):  
	list_display = ['orderid','paid']	

admin.site.register(OrderList,OrderListAdmin)
admin.site.register(Order,OrderListAdmin2)