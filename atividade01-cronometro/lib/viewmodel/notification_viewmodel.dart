import '../services/notification_service.dart';

class NotificationViewModel {
  final NotificationService _notificationService = NotificationService();

  Future<void> initialize() async {
    await _notificationService.initialize();
  }

  Future<void> showCronometroAtivo() async {
    await _notificationService.showNotification(
      title: 'Cronômetro em andamento',
      body: 'Seu cronômetro está ativo.',
      id: 1,
    );
  }

  Future<void> showVoltaRegistrada({required String lapTime, required String totalTime}) async {
    await _notificationService.showNotification(
      title: 'Volta registrada',
      body: 'Tempo da volta: $lapTime, tempo total: $totalTime',
      id: 2,
    );
  }

  Future<void> showCronometroInativo() async {
    await _notificationService.showNotification(
      title: 'Cronômetro pausado',
      body: 'Seu cronômetro está pausado há mais de 10 segundos.',
      id: 3,
    );
  }
}
