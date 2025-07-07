from django.apps import AppConfig
from django.utils.translation import gettext_lazy as _


class ErpConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'erp'
    verbose_name = _('ERP Система')

    def ready(self):
        """Импортируем сигналы при запуске приложения"""
        import erp.signals 