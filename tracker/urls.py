from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('budgets/', views.budget_list, name='budget_list'),
    path('submit-report/', views.submit_report, name='submit_report'),
    path('reports/', views.report_list, name='report_list'),
]