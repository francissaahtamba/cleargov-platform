from django.contrib import admin
from .models import Budget, Report

@admin.register(Budget)
class BudgetAdmin(admin.ModelAdmin):
    list_display = ('project_name', 'sector', 'allocated_amount', 'spent_amount', 'date_created')

@admin.register(Report)
class ReportAdmin(admin.ModelAdmin):
    list_display = ('reporter_name', 'location', 'is_anonymous', 'date_reported', 'is_approved')
    list_filter = ('is_anonymous', 'is_approved', 'date_reported')
    search_fields = ('reporter_name', 'location', 'description')
    list_editable = ('is_approved',)  # Allow quick toggle in admin