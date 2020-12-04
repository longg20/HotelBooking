/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longtt.utilities;

import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;

/**
 *
 * @author User
 */
public class MailObj {

    private static final Logger LOGGER = Logger.getLogger(MailObj.class);

    public static String sendMail(String to, String type) {

        String subject = "";
        if (type.equals("ConfirmCart"))
                subject = "Verify Booking Order";
            if (type.equals("ConfirmReset"))
                subject = "Verify Password Change";
        String msg = "";
        for (int i = 0; i < 6; i++) {
            msg += new Random().nextInt(10);
        }

        final String username = "asm3.hotelbooking@gmail.com";//your email id
        final String password = "a9507173";// your password

        Properties props = new Properties();
        props.put("mail.smtp.auth", true);
        props.put("mail.smtp.starttls.enable", true);
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(to));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            if (type.equals("ConfirmCart"))
                message.setText("Confirm your Booking Order with this code: " + msg + "\n");
            if (type.equals("ConfirmReset"))
                message.setText("Confirm your Password Reset with this code: " + msg + "\n");
            Transport.send(message);
        } catch (Exception e) {
            LOGGER.error("Error at MailObj: " + e.getMessage());
        }
        return msg;
    }
}
