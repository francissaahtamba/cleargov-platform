from django.db import models

class UserBudget(models.Model):
    name = models.CharField(max_length=100)
    department = models.CharField(max_length=100)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    description = models.TextField()
    submitted_at = models.DateTimeField(auto_now_add=True)

    def _str_(self):
        return f"{self.name} - {self.department} - ${self.amount}"

class CorruptionReport(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    evidence = models.FileField(upload_to='evidence/')
    is_approved = models.BooleanField(default=False)
    submitted_at = models.DateTimeField(auto_now_add=True)

    def _str_(self):
        return f"{self.title} ({'Approved' if self.is_approved else 'Pending'})"