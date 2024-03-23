package suktha.app;


import suktha.impl.EmailSender;
import java.io.FileNotFoundException;
import java.io.File;


public class App {
        public static void main(String[] args) throws FileNotFoundException {

            EmailSender  sendEmail = new EmailSender();
            String to = "rshashu18@gmail.com";
            String from = "sshashu777@gmail.com";
            String subject = "Email with Text and File";
            String text = "This is a invoice with this email you can find out.";
            File file = new File("F:/pics/minions.jpg");


            boolean b = sendEmail.sendEmailWithAttachment(to, from, subject, text, file);
            if (b) {
                System.out.println("Email is sent successfully");
            } else {
                System.out.println("Error in sending email !!");
            }


            //        boolean b = gEmailSender.sendEmail(to, from, subject, text);
//        if (b) {
//            System.out.println("Email is sent successfully");
//        } else {
//            System.out.println("There is problem in sending email");
//        }


        }
    }

