class Notifier < ActionMailer::Base
	def crossing_notify(message)
		@recipients = ['malin@nvisiongroup.ru','anakho@nvisiongroup.ru']
		@from = 'Cross <sdesk@nvisiongroup.ru>'
		@subject = 'Уведомление о кроссировке'
		@body['text'] = message.to_s
	end
end
