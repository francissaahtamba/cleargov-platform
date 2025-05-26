from django.shortcuts import render, redirect
from .models import Budget, Report
from django.http import HttpResponse
from .models import Report

def home(request):
    return render(request, 'tracker/home.html')

import json  # 👈 make sure this is at the top if not already

def budget_list(request):
    budgets = Budget.objects.all()
    labels = [b.project_name for b in budgets]
    allocated = [float(b.allocated_amount) for b in budgets]
    spent = [float(b.spent_amount) for b in budgets]

    context = {
        'labels': json.dumps(labels),
        'allocated': json.dumps(allocated),
        'spent': json.dumps(spent),
    }
    return render(request, 'tracker/budget_list.html', context)

def submit_report(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        location = request.POST.get('location')
        description = request.POST.get('description')
        is_anonymous = request.POST.get('anonymous') == 'on'
        evidence = request.FILES.get('evidence')

        Report.objects.create(
            reporter_name=name if not is_anonymous else '',
            location=location,
            description=description,
            evidence=evidence,
            is_anonymous=is_anonymous
        )
        return HttpResponse('Report submitted successfully!')
    return render(request, 'tracker/submit_list.html')
  # Make sure this is already at the top

def report_list(request):
    reports = Report.objects.all().order_by('-date_reported')
    return render(request, 'tracker/report_list.html', {'reports': reports})