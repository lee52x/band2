package com.band.common;

import java.io.File;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.springframework.stereotype.Service;

import com.band.account.fee.Mail;

@Service("mailSender")
public class MailSender {
	private String mailType;
	private String encType;
	
	public MailSender(){
		this.encType = "ecu-kr";
		this.mailType="text/html; charset="+encType;
		//mailType="text/plain; charset=euc-kr"; -�Ϲ� �ؽ�Ʈ ����
	}
	
	private class SMTPAuth extends javax.mail.Authenticator {
		@Override
		public PasswordAuthentication getPasswordAuthentication() {
			String username="nuridaservice";
			String pwd="nurida1234";
			return new PasswordAuthentication(username, pwd);
		}
	}
	
	public boolean mailSend(Mail dto){
		boolean b=true;
		
		Properties p=new Properties();
		
		// SMTP ���� ����
		p.put("mail.smtp.user", "nuridaservice");
		
		// SMTP ���� ���� ����
		p.put("mail.smtp.host", "smtp.gmail.com"); // ������
		
		// ������ ���̹� ����
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		try {
			Authenticator auth=new SMTPAuth();
			Session session=Session.getDefaultInstance(p, auth);
			
			session.setDebug(true);
			
			Message message=new MimeMessage(session);
			
			// ������ ���
			if(dto.getSenderName().length()!=0){
				message.setFrom(new InternetAddress(dto.getSenderEmail()));
			}else{
				message.setFrom(new InternetAddress(dto.getSenderEmail(), dto.getSenderName(),"euc-kr"));
			}
			
			// �޴� ���
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dto.getReceiverEmail()));
			
			// ����
			message.setSubject(dto.getSubject());
			
			// HTML �� ��� \n�� <br>��
			if(mailType.indexOf("text/html")!=-1){
				dto.setContent(
						dto.getContent().replaceAll("\n", "<br>"));
			}
			
			makeMessage(message, dto);
			message.setHeader("X-Mailer", dto.getSenderName());
			
			// ��¥
			message.setSentDate(new Date());
			
			// ����
			Transport.send(message);
			
			// ���� ���� �� ���� �����
			if(dto.getPathname()!=null){
				File f=new File(dto.getPathname());
				if(f.exists()){
					f.delete();
				}
			}
		} catch (Exception e) {
			b=false;
			System.out.println(e.toString());
		}
		
		return b;
	}
	
	private void makeMessage(Message msg, Mail dto) throws MessagingException{
		if(dto.getPathname()==null){
			// ÷�������� ���� ���
			msg.setText(dto.getContent());
			msg.setHeader("Content-Type", mailType);
		} else {
			// ÷�������� �ִ� ���
			
			// ���� ����
			MimeBodyPart p1=new MimeBodyPart();
			p1.setText(dto.getContent());
			p1.setHeader("Content-Type", mailType);
			// ÷�� ����
			MimeBodyPart p2=new MimeBodyPart();
			FileDataSource fds=new FileDataSource(dto.getPathname());
			p2.setDataHandler(new DataHandler(fds));
			
			try {
				if(dto.getOriginalFilename()==null){
					p2.setFileName(MimeUtility.encodeWord(fds.getName()));
				} else {
					p2.setFileName(MimeUtility.encodeWord(dto.getOriginalFilename()));
				}
			} catch (Exception e) {
			}
			
			Multipart mp=new MimeMultipart();
			mp.addBodyPart(p1);
			mp.addBodyPart(p2);
			
			msg.setContent(mp);
		}
	}
}
