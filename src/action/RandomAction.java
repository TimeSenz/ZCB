package action;

import java.io.ByteArrayInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import sms_api.Sms;
import util.RandomNumUtil;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class RandomAction extends ActionSupport {
	private ByteArrayInputStream inputStream;

	public String execute() throws Exception {
		System.out.println("1111");
		RandomNumUtil rdnu = RandomNumUtil.Instance();
		this.setInputStream(rdnu.getImage());// ȡ�ô�������ַ�����ͼƬ
		ActionContext.getContext().getSession().put("random", rdnu.getString());// ȡ������ַ�������HttpSession
		HttpServletRequest   request = ServletActionContext.getRequest();
		System.out.println(rdnu.getString()+"phone"+request.getParameter("phone"));
		Sms smsUtil=new Sms();
		smsUtil.sms_register(request.getParameter("phone"), rdnu.getString());
		return SUCCESS;
	}
	public String test() throws Exception {
		System.out.println("1111");
		RandomNumUtil rdnu = RandomNumUtil.Instance();
		this.setInputStream(rdnu.getImage());// ȡ�ô�������ַ�����ͼƬ
		ActionContext.getContext().getSession().put("random", rdnu.getString());// ȡ������ַ�������HttpSession
		HttpServletRequest   request = ServletActionContext.getRequest();
		System.out.println(rdnu.getString()+"phone"+request.getParameter("phone"));
		Sms smsUtil=new Sms();
		smsUtil.sms_register(request.getParameter("phone"), rdnu.getString());
		return SUCCESS;
	}


	public void setInputStream(ByteArrayInputStream inputStream) {
		this.inputStream = inputStream;
	}

	public ByteArrayInputStream getInputStream() {
		return inputStream;
	}

	String random;

	public void testLogin() {
		System.out.println("������֤�룺"+ActionContext.getContext().getSession().get("random") + " ��ȡ��֤�룺" + random);
	}

	public String getRandom() {
		return random;
	}

	public void setRandom(String random) {
		this.random = random;
	}

}