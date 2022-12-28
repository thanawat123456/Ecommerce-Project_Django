from django import template  #{% load custom_tags %} ในไฟล์ base.html
from ..models import  Category,AllProduct   #..คือถอยไป2โฟเดอร์

register = template.Library()


@register.simple_tag
def hello_tag():
	#{% heloo_tag %}
	return '<---- Hello Tag ---->'
	

@register.simple_tag
def show_addproduct():
	count = AllProduct.objects.count()
	return count

@register.inclusion_tag('myapp/allcategory.html')
def all_category():
	cats = Category.objects.all()
	return {'allcats': cats}




