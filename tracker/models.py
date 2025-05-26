from django.db import models

# Budget model
class Budget(models.Model):
    project_name = models.CharField(max_length=255)
    sector = models.CharField(max_length=100)
    allocated_amount = models.DecimalField(max_digits=12, decimal_places=2)
    spent_amount = models.DecimalField(max_digits=12, decimal_places=2)
    date_created = models.DateTimeField(auto_now_add=True)

    def _str_(self):
        return f"{self.project_name} - {self.sector}"

# Corruption Report model
class Report(models.Model):
    reporter_name = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    description = models.TextField()
    evidence = models.FileField(upload_to='evidence/', null=True, blank=True)
    is_anonymous = models.BooleanField(default=False)
    date_reported = models.DateTimeField(auto_now_add=True)
    is_approved = models.BooleanField(default=False)  # 👈 NEW FIELD


    def _str_(self):
        return f"Report from {self.reporter_name or 'Anonymous'}"
