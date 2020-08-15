package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator{

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("####@naver.com","####"); // 이메일 주소와 비밀번호 입력
    }
}