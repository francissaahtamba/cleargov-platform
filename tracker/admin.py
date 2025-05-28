from django.contrib import admin
from .models import UserBudget, CorruptionReport

@admin.register(UserBudget)
class UserBudgetAdmin(admin.ModelAdmin):
    list_display = ('name', 'department', 'amount', 'submitted_at')
    search_fields = ('name', 'department')
    list_filter = ('department', 'submitted_at')

@admin.register(CorruptionReport)
class CorruptionReportAdmin(admin.ModelAdmin):
    list_display = ('title', 'is_approved', 'submitted_at')
    list_filter = ('is_approved', 'submitted_at')
    search_fields = ('title',)
    actions = ['approve_reports']

    def approve_reports(self, request, queryset):
        queryset.update(is_approved=True)
    approve_reports.short_description = "Mark selected reports as approved"