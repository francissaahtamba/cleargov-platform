from django.shortcuts import render, redirect
from .models import UserBudget, CorruptionReport
import json

def home(request):
    return render(request, 'tracker/home.html')

def budget_list(request):
    budgets = UserBudget.objects.all()
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
        name = request.POST.get('name', '').strip()
        location = request.POST.get('location', '').strip()
        description = request.POST.get('description', '').strip()
        is_anonymous = request.POST.get('anonymous') == 'on'
        evidence = request.FILES.get('evidence')

        if not (location and description):
            return render(request, 'tracker/submit_list.html', {
                'error': 'Location and description are required.'
            })

        CorruptionReport.objects.create(
            reporter_name=name if not is_anonymous else '',
            location=location,
            description=description,
            evidence=evidence,
            is_anonymous=is_anonymous
        )

        return redirect('report_list')

    return render(request, 'tracker/submit_list.html')

def report_list(request):
    reports = CorruptionReport.objects.filter(is_approved=True).order_by('-date_reported')
    return render(request, 'tracker/report_list.html', {'reports': reports})