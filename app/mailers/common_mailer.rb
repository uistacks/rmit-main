class CommonMailer < ApplicationMailer
	def send_email(mail_details,path = "",filename = "")
		if path.blank? == false then
	 		attachments[filename] = {mime_type: 'application/vnd.ms-excel', content: File.read(path.to_s + filename.to_s)}
			# attachments['sadsa-excel.xlsx'] = File.read('/home/administrator/Documents/ROR/p1051/tmp/sadsa-excel.xlsx')
			mail(
					from: mail_details[:from],
					to: mail_details[:to],
					subject: mail_details[:subject],
					body: mail_details[:body]
			)
		else
			mail(
					from: mail_details[:from],
					to: mail_details[:to],
					subject: mail_details[:subject],
					body: mail_details[:body],
					content_type: "text/html"
			)
	 	end
	end
end
