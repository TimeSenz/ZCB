package action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import dao.Bidinfo;
import dao.BidinfoDAO;
import dao.Bidinfo_Userinfo;
import dao.Cominfo;
import dao.CominfoDAO;
import dao.Finance;
import dao.Finplan;
import dao.Jkract;
import dao.Records;
import dao.RecordsDAO;
import dao.Riskinfo;
import dao.Tempdata;
import dao.Userinfo;
import dao.UserinfoDAO;
import service.BidinfoService;
import service.JkractService;
import service.NewsinfoService;
import service.RootactService;
import service.TempdataService;
import service.UserinfoService;
import util.LogicUtil;
import util.Paging;

public class BidinfoAction {
	Userinfo userinfo = new Userinfo();
	Bidinfo bidinfo = new Bidinfo();
	BidinfoService bidinfoservice = new BidinfoService();
	List bidinfolist = new ArrayList();
	Paging paging = new Paging();
	LogicUtil logicutil = new LogicUtil();
	String money;
	TempdataService tempdataservice = new TempdataService();
	Tempdata tempdata = new Tempdata();
	JkractService jkractservice = new JkractService();
	Jkract jkract = new Jkract();
	UserinfoService userinfoservice = new UserinfoService();
	List userinfolist = new ArrayList();
	Userinfo jkr = new Userinfo();
	RootactService rootactservice = new RootactService();
	List lcrbuyinfo = new ArrayList();
	List haveonbidlist = new ArrayList();
	List waitbidlist = new ArrayList();
	List repayplan = new ArrayList();
	Integer a = 0;

	BidinfoDAO bidinfodao = new BidinfoDAO();
	RecordsDAO recordsdao = new RecordsDAO();
	CominfoDAO cominfodao = new CominfoDAO();

	// ��ѯbidlist
	List BidList = new ArrayList();
	// ��ɢ��
	List finance_bid_list = new ArrayList();
	Finplan finplan = new Finplan();
	List all_finance_list = new ArrayList();
	// ��ҳ��ʾ�����Ŷ�̬�����Ź���
	List firstgonglist = new ArrayList();
	List firstdonglist = new ArrayList();
	List firsthuanlist = new ArrayList();
	List firstmeilist = new ArrayList();
	NewsinfoService newsinfoservice = new NewsinfoService();
	UserinfoDAO userinfodao = new UserinfoDAO();
	List allfinancelist = new ArrayList();
	// Э���н���˵���Ϣ
	List jkrlist = new ArrayList();
	// ��ѡ�����Ѱ󶨵�ɢ��list
	List bdsblist = new ArrayList();
	// ��������
	List guacomlist = new ArrayList();
	// ������˾
	String guacom;
	/**
	 * ��ҳ��ѯ
	 * 
	 * @return
	 */
	private int currentPage;
	private final int pageSize = 10;
	private int totalPage;
	private int areaPage;
	private String uploader;
	private List<File> file;
	private List<String> fileFileName;
	private List<String> fileContentType;

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getAreaPage() {
		return areaPage;
	}

	public void setAreaPage(int areaPage) {
		this.areaPage = areaPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	// ��ҳ���ͷҳ�����ת
	public String home() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String flag = request.getParameter("home");
		// ��Ҫ���
		if (flag.equals("borrowed")) {
			return "borrowed";
		}
		// ��Ҫ����
		if (flag.equals("lenders")) {
			return "lenders";
		}
		// ����ָ��
		if (flag.equals("New")) {
			return "New";
		}
		// ��ȫ����
		if (flag.equals("insurance")) {
			return "insurance";
		}
		// 3�������ƶ���
		if (flag.equals("introduce")) {
			return "introduce";
		}
		// ��������
		if (flag.equals("agency")) {
			return "agency";
		}
		// ��������
		if (flag.equals("questions")) {
			return "questions";
		}
		return "success";
	}

	// ��ѯ����
	public String findAll() {
		/**
		 * ��ҳ
		 */
		HttpServletRequest request = ServletActionContext.getRequest();

		if (currentPage == 0) {
			currentPage = 1;
		}
		if (areaPage == 0) {
			areaPage = 1;
		}
		// ����������˾����
		ActionContext ac = ActionContext.getContext();
		Riskinfo riskinfo = (Riskinfo) ac.getSession().get("riskinfo");

		int stratLine = (currentPage - 1) * pageSize;// ��ǰҳ��֮ǰ������
		bidinfolist = bidinfoservice.findAll(stratLine, riskinfo);
		List totalList = bidinfodao.findAllTotalNum();// ������
		if (totalList == null || totalList.size() == 0) {
			totalPage = 0;
		}
		if (totalList.size() <= 10) {
			totalPage = 1;
		} else {
			if (totalList.size() % 10 == 0) {
				totalPage = totalList.size() / 10;
			} else {
				totalPage = totalList.size() / 10 + 1;
			}
		}

		request.setAttribute("totalPage", new Integer(totalPage));
		request.setAttribute("areaPage", new Integer(areaPage));
		request.setAttribute("currentPage", new Integer(currentPage));
		// ��ѯ���е��û�
		userinfolist = userinfoservice.findAll();
		return "findall";
	}

	// �޸ı�����
	public String updateBid() {
		HttpServletRequest request = ServletActionContext.getRequest();
		bidinfo = bidinfoservice.findById(new Integer(request
				.getParameter("id")));
		userinfolist = userinfoservice.findJkr();// �����������Ϣ
		return "success";

	}

	// ���������
	public String saveBid() {
		bidinfoservice.modifyBid(bidinfo);
		// System.out.println("�������Ϣ�ɹ�");
		return "success";
	}

	// ɾ����
	public String delectBid() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		bidinfoservice.delectBid(new Integer(id));
		// System.out.println("ɾ����id="+id);
		return "success";
	}

	// ����޸ľ�ѡ����
	public String updateFinance() {
		bdsblist.clear();
		HttpServletRequest request = ServletActionContext.getRequest();
		bidinfo = bidinfoservice.findById(new Integer(request
				.getParameter("id")));
		userinfo = userinfoservice.findById(bidinfo.getUserid());
		// ��ѯ���С�δ�ϱꡱ�ı�
		bidinfolist = bidinfoservice.findActBid("δ�ϱ�");
		// ��ѯ���þ�ѡ�����Ѿ���ɢ��
		String bs = (String) userinfodao.findById(bidinfo.getUserid())
				.getRemain();
		String[] ba = bs.split("#");
		for (int i = 0; i < ba.length; i++) {
			Bidinfo bid = new Bidinfo();
			bid = bidinfoservice.findById(new Integer(ba[i]));
			bdsblist.add(bid);
		}
		return "success";
	}

	// ȷ���޸ľ�ѡ����
	public String upSureFinance() {
		HttpServletRequest request = ServletActionContext.getRequest();
		// ��øþ�ѡ������bidinfo���е���Ϣ
		Bidinfo bid = (Bidinfo) bidinfoservice.findById(new Integer(request
				.getParameter("id")));
		// �þ�ѡ������ǰ�󶨵�ɢ��
		String bs = (String) userinfodao.findById(bid.getUserid()).getRemain();
		String[] ba = bs.split("#");
		// �ж�֮ǰ���󶨵�ɢ��
		for (int a = 0; a < ba.length; a++) {
			int beforesb = new Integer(ba[a]);
			// ��ȡ�ƻ�����
			String[] bidarr = request.getParameterValues("bidinfo");
			StringBuffer s = new StringBuffer();
			for (int f = 0; f < bidarr.length; f++) {
				if (beforesb == new Integer(bidarr[f])) {
				} else {
					// �����ǰ�󶨵�ɢ�겻�������°󶨵�ɢ�����Ӧ�ø���״̬Ϊ��δ�ϱꡱ ���ı�remark
					Bidinfo bidinfo = new Bidinfo();
					bidinfo = bidinfoservice.findById(beforesb);
					bidinfo.setState("δ�ϱ�");
					bidinfo.setRemark("");
					bidinfoservice.modifyBid(bidinfo); // �ı���״̬
				}
			}
		}
		// �Ծ�ѡ���Ƽƻ����и���
		// ��ȡ�ƻ����ƣ�����ѡ���ɢ�����״̬Ϊ�������ϡ���remark
		String[] bidarr = request.getParameterValues("bidinfo");
		StringBuffer s = new StringBuffer();
		for (int f = 0; f < bidarr.length; f++) {
			Bidinfo bidd = new Bidinfo();
			bidd = bidinfoservice.findById(new Integer(bidarr[f]));
			bidd.setState("������");
			bidd.setRemark("�Ѽ��뵽   " + finplan.getPlanname() + "  ��ѡ���Ƽƻ���");
			bidinfoservice.modifyBid(bidd); // �ı���״̬
			s.append(bidarr[f]);
			s.append("#");
		}
		String bidinfo = s.toString();
		// ��øþ�ѡ������userinfo���е���Ϣ��update
		userinfo = userinfoservice.findById(bid.getUserid());
		userinfo.setName(finplan.getPlanname());
		userinfo.setRemain(bidinfo);
		userinfoservice.modify(userinfo);
		userinfo = (Userinfo) userinfoservice.findByName(userinfo.getName())
				.get(0);
		String[] bidStrArray = bidinfo.split("#");
		// update bidinfo���е���Ϣ
		Bidinfo test = new Bidinfo();
		test = bidinfoservice.findById(new Integer(bidStrArray[0]));
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());
		bid.setCreated(nowtime);
		bid.setDeadline(test.getDeadline());
		bid.setProfit((double) finplan.getProfit());
		bid.setRemark(bidinfo);
		bid.setReason(finplan.getPlaninfo());
		bid.setUserid(userinfo.getUserid());
		bid.setRepaytype(finplan.getRepaytype());
		double money = 0.0;
		for (int i = 0; i < bidStrArray.length; i++) {
			test = bidinfoservice.findById(new Integer(bidStrArray[i]));
			money = (double) (money + test.getNumber().intValue());
		}
		bid.setNumber(money);
		bid.setMoney(money);
		bidinfoservice.modify(bid);
		bidinfolist = bidinfoservice.findAllFinance();
		return "success";
	}

	// �Ծ�ѡ���ƽ��С����ߡ�
	public String offlineFinance() {
		HttpServletRequest request = ServletActionContext.getRequest();
		bidinfo = bidinfoservice.findById(new Integer(request
				.getParameter("id")));
		bidinfo.setState("������");
		bidinfoservice.modify(bidinfo);
		return "offlineFinance";
	}

	// ���澫ѡ����
	public String saveFinance() {
		bidinfoservice.modifyBid(bidinfo);
		userinfoservice.modify(userinfo);
		System.out.println("�������Ϣ�ɹ�");

		return "success";
	}

	// ɾ����ѡ����
	public String delectFinance() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		String userinfo = request.getParameter("userinfo");
		userinfoservice.delectUser(new Integer(userinfo));
		bidinfoservice.delectBid(new Integer(id));
		return "success";
	}

	// �����״̬��ѯ�����ϱꡱ����δ�ϱꡱ��ѯ���б�
	public String findByState() {
		HttpServletRequest request = ServletActionContext.getRequest();
		a = new Integer(request.getParameter("a"));
		// ����������˾����
		ActionContext ac = ActionContext.getContext();
		Riskinfo riskinfo = (Riskinfo) ac.getSession().get("riskinfo");

		if (currentPage == 0) {
			currentPage = 1;
		}
		if (areaPage == 0) {
			areaPage = 1;
		}
		int stratLine = (currentPage - 1) * pageSize;
		// δ�ϱ�
		if (a == 2) {
			waitbidlist = bidinfoservice
					.findByState("δ�ϱ�", stratLine, riskinfo);
			List list = bidinfodao.findBidNum("δ�ϱ�");
			if (list == null || list.size() == 0) {
				totalPage = 0;
			}
			if (list.size() <= 10) {
				totalPage = 1;
			} else {
				if (list.size() % 10 == 0) {
					totalPage = list.size() / 10;
				} else {
					totalPage = list.size() / 10 + 1;
				}
			}

			request.setAttribute("totalPage", new Integer(totalPage));
			request.setAttribute("areaPage", new Integer(areaPage));
			request.setAttribute("currentPage", new Integer(currentPage));
			userinfolist = userinfoservice.findAll();
			return "wait";
		}
		// ���ϱ�
		else if (a == 1) {
			haveonbidlist = bidinfoservice.findByState("none", stratLine,
					riskinfo);
			List holist = bidinfodao.findBidNum("none");
			if (holist == null || holist.size() == 0) {
				totalPage = 0;
			}
			if (holist.size() <= 10) {
				totalPage = 1;
			} else {
				if (holist.size() % 10 == 0) {
					totalPage = holist.size() / 10;
				} else {
					totalPage = holist.size() / 10 + 1;
				}
			}

			request.setAttribute("totalPage", new Integer(totalPage));
			request.setAttribute("areaPage", new Integer(areaPage));
			request.setAttribute("currentPage", new Integer(currentPage));
			userinfolist = userinfoservice.findAll();
			return "havaon";
		}
		return "success";
	}

	// ��ѯ���н����
	public String addBid() {
		userinfolist = userinfoservice.findJkr();// �����������Ϣ
		return "addbid";
	}

	// ��ͼƬ�ϴ�Ĭ�Ϸ���
	public String execute() throws Exception {
		ActionContext ac = ActionContext.getContext();
		List countFileList = (List) ac.getSession().get("countFileList");
		if (countFileList == null) {
			countFileList = new ArrayList();
		}

		// TODO Auto-generated method stub
		// System.out.println("����action");
		//
		// System.out.println("uploader===="+uploader);
		// System.out.println("file===="+file);
		System.out.println("fileFileName====" + fileFileName);
		System.out.println("fileContentType====" + fileContentType);
		//
		// System.out.println("fileContentType.size()===="+fileContentType.size());
		// System.out.println("fileFileName.size()===="+fileFileName.size());

		String path = ServletActionContext.getRequest().getRealPath("uploadss");
		// System.out.println(path);
		File files = new File(path);
		// System.out.println(files);
		if (!files.exists()) {

			files.mkdirs();
			// System.out.println("files��Ϊ��");
		}
		for (int i = 0; i < file.size(); i++) {
			FileInputStream in = new FileInputStream(file.get(i));
			File targetFile = new File(path, this.getFileFileName().get(i));
			// System.out.println("targetFile=="+targetFile);
			FileOutputStream out = new FileOutputStream(targetFile);
			byte[] b = new byte[1024];
			int len = 0;
			while ((len = in.read(b)) != -1) {
				out.write(b, 0, len);

			}
			try {

				countFileList.add(fileFileName.toString().substring(1,
						fileFileName.toString().length() - 1));
				ac.getSession().put("countFileList", countFileList);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}

			out.close();
			in.close();
		}
		// return super.execute();
		return "success";
	}

	public String upload() {
		// System.out.println("������");
		return "success";
	}

	// �����µı�
	public String addBidinfo() {
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());

		// System.out.println(countFileList.size());

		// if(countFileList==null){
		// countFileList=new ArrayList();
		// }

		ActionContext ac = ActionContext.getContext();
		Riskinfo risk = (Riskinfo) ac.getSession().get("riskinfo");
		bidinfo.setComname(risk.getComname());
		bidinfo.setRiskinfo(risk.getId());

		bidinfo.setCreated(nowtime);
		bidinfo.setOverdue("��");
		bidinfo.setMoney(bidinfo.getNumber());
		bidinfo.setRate(0);

		// ActionContext ac = ActionContext.getContext();
		List countFileList = (List) ac.getSession().get("countFileList");
		// System.out.println(countFileList.size());
		String pic = "";
		if (countFileList != null) {
			for (int i = 0; i < countFileList.size(); i++) {
				// System.out.println(countFileList.get(i));
				pic += countFileList.get(i) + ",";

			}
			pic = pic.substring(0, pic.length() - 1);
			// System.out.println(pic);
			bidinfo.setPicture(pic);
			// System.out.println(bidinfo.getPicture());
		}
		bidinfoservice.addBidinfo(bidinfo);
		return "add";
	}

	// ������ϱꡱʱ�����±��״̬Ϊ��δ���ꡱ
	public String changeState() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Bidinfo vo = bidinfoservice.findById(Integer.parseInt(request
				.getParameter("id")));
		vo.setState("δ����");
		bidinfoservice.modify(vo);
		return "success";
	}

	// ��ҳ��ѯ
	public String findPaging() {
		bidinfoservice.findPaging(paging.getCurrentPage(),
				paging.getPageSize(), paging.getStart(), paging.getEnd());
		return "findpaging";
	}

	// ��ҳ��Ϣ����
	public String homePage() {
		bidinfolist = bidinfoservice.findPaging(1, 5, "2010-1-1", "2020-1-1");
		ActionContext ac = ActionContext.getContext();
		Map session = ActionContext.getContext().getSession();
		String flag = (String) session.get("loginflag");
		// System.out.println("+++++++"+flag);
		if (flag == null) {
			ac.getSession().put("loginflag", "0");
		}
		// System.out.println("homePage");

		// ��ҳ��ʾ���Ŷ�̬�����Ź���
		if (currentPage == 0) {
			currentPage = 1;
		}
		int stratLine = (currentPage - 1) * pageSize;
		firstgonglist = newsinfoservice.findFirstByType("��", stratLine, 5);
		firstdonglist = newsinfoservice.findFirstByType("��", stratLine, 5);
		firsthuanlist = newsinfoservice.findFirstByType("��", stratLine, 5);
		firstmeilist = newsinfoservice.findFirstByType("ý", stratLine, 5);
		allfinancelist.clear();
		// ��ҳ��ʾ��ѡ������Ϣ
		List<Bidinfo> list = new ArrayList();
		list = bidinfoservice.findAllFinance();

		// List<Bean> data = new ArrayList<Bean>();
		// Collections.sort(data, new Comparator<Bean>() {
		// public int compare(Bean o1, Bean o2) {
		// return o1.getName().compareTo(o2.getName());
		// }
		// });
		// System.out.println("��name����:" + data);

		// Collections.sort(list,);
		// Iterator<Bidinfo> it =list.iterator();
		// while(it.hasNext()){
		// System.out.println(it.next().getName());
		// }
		//

		for (Bidinfo b : list) {

			if (b.getState().equals("δ�ϱ�")) {

			} else {
				allfinancelist.add(b);
//				System.out.println("allfinancelist.size(): "
//						+ allfinancelist.size());
			}
		}

		return "homepage";
	}

	// ��������
	public String findByGuacom() {
		if (currentPage == 0) {
			currentPage = 1;
		}
		if (areaPage == 0) {
			areaPage = 1;
		}
		int stratLine = (currentPage - 1) * pageSize;// ��ǰҳ��֮ǰ������

		guacomlist = bidinfoservice.findByGuacom(stratLine, guacom);
		List totalList = bidinfodao.findGuacomTotalNum(guacom);// ������
		if (totalList == null || totalList.size() == 0) {
			totalPage = 0;
		}
		if (totalList.size() <= 10) {
			totalPage = 1;
		} else {
			if (totalList.size() % 10 == 0) {
				totalPage = totalList.size() / 10;
			} else {
				totalPage = totalList.size() / 10 + 1;
			}
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		request.setAttribute("totalPage", new Integer(totalPage));
		request.setAttribute("areaPage", new Integer(areaPage));
		request.setAttribute("currentPage", new Integer(currentPage));
		return "success";
	}

	// ����Id��ѯ��Ӧ��
	public String findById() throws NumberFormatException, ParseException {
		HttpServletRequest request = ServletActionContext.getRequest();
		bidinfo = bidinfoservice.findById(Integer.parseInt(request
				.getParameter("id")));
		jkr = userinfoservice.findById(bidinfo.getUserid());
		lcrbuyinfo = rootactservice.lcrBuyInfo(Integer.parseInt(request
				.getParameter("id")));
		// ����ƻ�
		if (bidinfo.getState().equals("������")) {
			repayplan = rootactservice.repayPlan(Integer.parseInt(request
					.getParameter("id")));
		} else {
			repayplan = null;
		}
		return "showone";
	}

	// ���
	public String buyBid() {
		HttpServletRequest request = ServletActionContext.getRequest();
		ActionContext ac = ActionContext.getContext();
		
		userinfo = userinfoservice.findByid(new Integer(request
				.getParameter("userid")));
		if (userinfo == null) {
			return "login";
		}
		
		buyBid(userinfo, bidinfo, money);
		
		ac.getSession().put("loginflag", "1");
		return "success";
	}

	// ���
	public void buyBid(Userinfo userinfo, Bidinfo bidinfo, String mon) {
		Double money = Double.parseDouble(mon);
		if (money <= bidinfo.getMoney() && money <= userinfo.getXjye()) {
			// �����û������Ϣ
			userinfo.setXjye(userinfo.getXjye() - money);
			
			userinfo.setJyje(userinfo.getJyje() + money);
			Double yqsy = money * bidinfo.getProfit() * bidinfo.getDeadline()
					/ 1200;
			userinfo.setYqsy(userinfo.getYqsy() + yqsy);
			userinfo.setZye(userinfo.getXjye() + userinfo.getYqsy()
					+ userinfo.getJyje());
			
			bidinfo.setMoney(bidinfo.getMoney() - money);
			bidinfo.setRate(Integer.parseInt(new java.text.DecimalFormat("0")
					.format((1 - bidinfo.getMoney() / bidinfo.getNumber()) * 100)));
		
			insertTempdata(bidinfo, userinfo, mon);
			
			insertRecords(userinfo, bidinfo, money);
			
			double flag = bidinfo.getMoney();
			
			if (flag == 0) {
				bidinfo.setState("������");
				// System.out.println("�Ѹ��±�״̬");
				insertJkract(bidinfo);
			} else {
			}
			// System.out.println("�������  "+bidinfo.getMoney());
			bidinfoservice.modifyBid(bidinfo);
		} else {
			// System.out.println("δ����");
		}
	}

	// ��� ����records��ˮ��
	public void insertRecords(Userinfo userinfo2, Bidinfo bidinfo2,
			Double money2) {
		Records records = new Records();
		Cominfo cominfo = new Cominfo();
		records.setType("���");
		records.setMoney(money2);
		cominfo = cominfodao.findById(0);
		records.setIntoinfo("��˾�й��˻�");
		records.setOuttoinfo(userinfo.getName());
		records.setPaytype("Fengpay");
		records.setPeople(userinfodao.findById(bidinfo2.getUserid()).getName());
		records.setBidid(bidinfo2.getId());
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());
		records.setTime(nowtime);
		records.setUserid(userinfo2.getUserid());
		records.setRemain("");
		records.setRemark(userinfo2.getRemark());
		cominfo.setTgzh(cominfo.getTgzh() + money2); // �˴����¹�˾�й��˻����
		records.setIntoacc(cominfo.getTgzh());
		userinfo2.setXjye(userinfo2.getXjye()); // ����Ҫ���� ���ʱ�Ѿ������� �����û��ֽ����˻���Ϣ
		records.setOutacc(userinfo2.getXjye());
		recordsdao.save(records);
		cominfodao.update(cominfo);
		userinfodao.update(userinfo2);
	}

	// ����������ת��
	public void insertTempdata(Bidinfo bidinfo, Userinfo userinfo, String mon) {
		Double money = Double.parseDouble(mon);
		Tempdata tempdata = new Tempdata();
		tempdata.setBidid(bidinfo.getId());
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());
		tempdata.setBuytime(nowtime);
		tempdata.setLcrid(userinfo.getUserid());
		tempdata.setMoney(money);
		tempdataservice.save(tempdata);
		// System.out.println("�Ѳ���������ת��");

	}

	// �������˲�����
	public void insertJkract(Bidinfo bidinfo) {
		jkract.setBidid(bidinfo.getId());
		jkract.setState("δ��׼");
		jkract.setZcrje(bidinfo.getNumber());
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());
		jkract.setTime(nowtime);
		jkractservice.save(jkract);
		// System.out.println("�Ѳ������˲�����");
	}

	// ����ɹ�����ת
	public String bidSuccessJump() {
		bidinfolist = bidinfoservice.findPaging(1, 5, "2010-1-1", "2020-1-1");
		return "success";
	}

	// ���Ӿ�ѡ����
	public String findActBid() {
		bidinfolist = bidinfoservice.findActBid("δ�ϱ�");
		return "success";
	}

	// �����������Ƽƻ�
	public String findAllFinanceplan() {
		bidinfolist = bidinfoservice.findAllFinance();
		// finance_bid_list=null;

		finance_bid_list.clear();

		List<Finplan> list = new ArrayList();
		Bidinfo bid = new Bidinfo();
		for (int i = 0; i < bidinfolist.size(); i++) {
			Finplan finplan_info = new Finplan();
			bid = (Bidinfo) bidinfolist.get(i);
			finplan_info.setBid_plan(bid);
			finplan_info.setBidinfolist(analyticRemark(bid.getRemark()));
			finplan_info.setPlanname(userinfoservice.findById(
					finplan_info.getBid_plan().getUserid()).getName());
			finplan_info.setPlaninfo(finplan_info.getBid_plan().getReason());
			finplan_info.setProfit((int) (double) finplan_info.getBid_plan()
					.getProfit());
			list.add(finplan_info);

			// System.out.println("bid_info: "+bid.getReason());
			// System.out.println("finplan_info: "+finplan_info.getBid_plan().getReason());
		}
		finance_bid_list = list;
		// System.out.println("finance_bid_list_size: "+finance_bid_list.size());
		// for(int i=0;i<list.size();i++){
		// System.out.println("finplan_info: "+list.get(i).getBid_plan().getReason());

		// }
		return "success";
	}

	// ������ѡ���Ʊ�ע��Ϣ return list
	public List analyticRemark(String remark) {
		String[] bidStrArray = remark.split("#");
		List<Bidinfo> bid_list = new ArrayList();
		Bidinfo tem_bid = new Bidinfo();
		for (int i = 0; i < bidStrArray.length; i++) {

			tem_bid = bidinfoservice.findById(new Integer(bidStrArray[i]));
			bid_list.add(tem_bid);
		}

		return bid_list;
	}

	// ������ѡ���Ƽƻ�
	public String showAllFinance() {
		List<Bidinfo> list = new ArrayList();
		list = bidinfoservice.findAllFinance();
		for (Bidinfo b : list) {

			if (b.getState().equals("δ�ϱ�")) {
			} else {
				all_finance_list.add(b);
			}
		}
		// System.out.println("all_finance_list.size(): "+all_finance_list.size());
		return "success";
	}

	// �������Ƽƻ�
	public String addFinanceplan() {

		HttpServletRequest request = ServletActionContext.getRequest();
		// ��ȡɢ��ѡ����Ϣ
		String bidinfo = request.getParameter("bidinfo");
		// System.out.println("request.getParameter: "+bidinfo);
		// ��ȡ�ƻ�����
		String[] bidarr = request.getParameterValues("bidinfo");
		// System.out.println("bidarr.length:  "+bidarr.length);
		StringBuffer s = new StringBuffer();
		for (int f = 0; f < bidarr.length; f++) {
			Bidinfo bid = new Bidinfo();
			bid = bidinfoservice.findById(new Integer(bidarr[f]));
			bid.setState("������");
			bid.setRemark("�Ѽ��뵽   " + finplan.getPlanname() + "  ��ѡ���Ƽƻ���");
			bidinfoservice.modifyBid(bid); // �ı���״̬
			s.append(bidarr[f]);
			s.append("#");
		}
		bidinfo = s.toString();
		// bidinfo="10000#10001#10002";
		// finplan.setPlanname("ZCB10001");
		// finplan.setPlaninfo("�ڲƱ�����Ͷ�ʰ�Ǯ��ƽ̨������Ǯͨ��ĿΪ�����ģ��Ƚ�����ȫ�������͸���ȸߵ���ѡͶ�ʼƻ���Ͷ�����������������ѡ���Զ���ȡ����ÿ�»ؿ�ı��𲿷�������Ͷ�ʡ������ڽ����󣬿�������ѡ���˳��ƻ���");
		// finplan.setRepaytype("�·�Ϣ");

		Userinfo user_plan = new Userinfo();
		user_plan.setName(finplan.getPlanname());
		user_plan.setRemain(bidinfo);
		user_plan.setJkr("0");
		userinfoservice.save(user_plan);
		user_plan = (Userinfo) userinfoservice.findByName(user_plan.getName())
				.get(0);
		// System.out.println("user_plan:  "+user_plan.getUserid());
		// ������String������List
		// List<String> bidinfolist_string=analysis(bidinfo);
		String[] bidStrArray = bidinfo.split("#");
		// System.out.println("bid_String:  "+bidinfo);
		Bidinfo test = new Bidinfo();
		test = bidinfoservice.findById(new Integer(bidStrArray[0]));
		Bidinfo finance_bid = new Bidinfo();
		finance_bid.setBidtype("��");
		Timestamp nowtime = new Timestamp(System.currentTimeMillis());
		finance_bid.setCreated(nowtime);

		finance_bid.setDeadline(test.getDeadline());
		finance_bid.setProfit((double) finplan.getProfit());
		finance_bid.setRate(0);
		finance_bid.setRemark(bidinfo);
		finance_bid.setReason(finplan.getPlaninfo());
		finance_bid.setUserid(user_plan.getUserid());

		finance_bid.setReason(finplan.getPlaninfo());
		finance_bid.setRepaytype(finplan.getRepaytype());
		finance_bid.setOverdue("��");
		finance_bid.setState("δ�ϱ�");

		double money = 0.0;

		for (int i = 0; i < bidStrArray.length; i++) {
			test = bidinfoservice.findById(new Integer(bidStrArray[i]));
			// System.out.println("bidid: "+bidStrArray[i]);
			System.out.println("test.reason: " + test.getReason());
			money = (double) (money + test.getNumber().intValue());
			// System.out.println("��ǰ�� "+money+" ���ӽ�"+test.getNumber());
		}
		finance_bid.setNumber(money);
		finance_bid.setMoney(money);

		bidinfoservice.save(finance_bid);
		// System.out.println("����finance_bid");

		bidinfolist = bidinfoservice.findAllFinance();
		// System.out.println("size++++"+bidinfolist.size());

		return "success";
	}

	// ȷ�����Ƽƻ�
	public String conFinanceplan() {

		HttpServletRequest request = ServletActionContext.getRequest();
		String[] bidarr = request.getParameterValues("conFinance_info");
		// System.out.println("bidarr.length:  "+bidarr.length);
		// System.out.println("conFinanceplan:bidarr.length:"+bidarr.length);
		List<Bidinfo> finlist = new ArrayList();
		finlist = bidinfoservice.findAllFinance();
		for (Bidinfo b : finlist) {

			b.setState("δ�ϱ�");
			bidinfoservice.modifyBid(b); // ����������ϱ��¼

		}
		if (bidarr.length > 0) {
			for (int f = 0; f < bidarr.length; f++) {

				Bidinfo bid = new Bidinfo();
				bid = bidinfoservice.findById(new Integer(bidarr[f]));
				bid.setState("δ����");

				bidinfoservice.modifyBid(bid); // �ı���״̬
				System.out.println("�ı侫ѡ���ƣ�" + bidarr[f]);

			}

		}

		return "success";
	}

	public String showOneFinance() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		// bidinfo=bidinfoservice.findById(Integer.parseInt(request.getParameter("id")));
		bidinfo = bidinfoservice.findById(Integer.parseInt(id));

		String[] bidArr = bidinfo.getRemark().split("#");
		finplan.setBid_plan(bidinfo);
		List list = new ArrayList();
		for (int i = 0; i < bidArr.length; i++) {
			list.add(bidinfoservice.findById(new Integer(bidArr[i])));

		}
		finplan.setBidinfolist(list);
		System.out.println(finplan.getBid_plan().getUserid());
		finplan.setPlanname(userinfoservice.findById(
				finplan.getBid_plan().getUserid()).getName());
		finplan.setPlaninfo(finplan.getBid_plan().getReason());
		lcrbuyinfo = rootactservice.lcrBuyInfo(Integer.parseInt(request
				.getParameter("id")));
		// System.out.println("finplan.size:  "+list.size());
		return "showone";
	}

	// public List<String> analysis(String bidinfo){
	//
	// String a=str.substring(0,str.indexOf("&"));
	// String b=str.substring(str.indexOf("&")+1,str.indexOf("#"));
	//
	// List<String> bidinfolist=new ArrayList();
	// String[] bidStrArray=bidinfo.split("#");
	// for(int i=0;i<bidStrArray.length;i++)
	// {
	// System.out.println("           "+bidStrArray[i]);
	// }
	// bidinfolist.add("10000");
	// bidinfolist.add("10001");
	// bidinfolist.add("10002");
	// return bidinfolist;
	//
	// }

	// ����Э��
	public String creatxieyi() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String userid = request.getParameter("userid");

		// �����˼�¼
		lcrbuyinfo = rootactservice.lcrBuyInfo(Integer.parseInt(request
				.getParameter("bidid")));
		jkrlist = bidinfoservice.creatxieyi(
				Integer.parseInt(request.getParameter("userid")),
				Integer.parseInt(request.getParameter("bidid")));
		bidinfo = bidinfodao.findById(Integer.parseInt(request
				.getParameter("bidid")));
		if (bidinfo.getBidtype().equals("��")) {

			return "fanance";
		}

		return "success";
	}

	public BidinfoService getBidinfoservice() {
		return bidinfoservice;
	}

	public void setBidinfoservice(BidinfoService bidinfoservice) {
		this.bidinfoservice = bidinfoservice;
	}

	public List getBidinfolist() {
		return bidinfolist;
	}

	public void setBidinfolist(List bidinfolist) {
		this.bidinfolist = bidinfolist;
	}

	public Paging getPaging() {
		return paging;
	}

	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	public Bidinfo getBidinfo() {
		return bidinfo;
	}

	public void setBidinfo(Bidinfo bidinfo) {
		this.bidinfo = bidinfo;
	}

	public Userinfo getUserinfo() {
		return userinfo;
	}

	public void setUserinfo(Userinfo userinfo) {
		this.userinfo = userinfo;
	}

	public LogicUtil getUtil() {
		return logicutil;
	}

	public void setUtil(LogicUtil util) {
		this.logicutil = util;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public LogicUtil getLogicutil() {
		return logicutil;
	}

	public void setLogicutil(LogicUtil logicutil) {
		this.logicutil = logicutil;
	}

	public TempdataService getTempdataservice() {
		return tempdataservice;
	}

	public void setTempdataservice(TempdataService tempdataservice) {
		this.tempdataservice = tempdataservice;
	}

	public Tempdata getTempdata() {
		return tempdata;
	}

	public void setTempdata(Tempdata tempdata) {
		this.tempdata = tempdata;
	}

	public JkractService getJkractservice() {
		return jkractservice;
	}

	public void setJkractservice(JkractService jkractservice) {
		this.jkractservice = jkractservice;
	}

	public Jkract getJkract() {
		return jkract;
	}

	public void setJkract(Jkract jkract) {
		this.jkract = jkract;
	}

	public UserinfoService getUserinfoservice() {
		return userinfoservice;
	}

	public void setUserinfoservice(UserinfoService userinfoservice) {
		this.userinfoservice = userinfoservice;
	}

	public List getUserinfolist() {
		return userinfolist;
	}

	public void setUserinfolist(List userinfolist) {
		this.userinfolist = userinfolist;
	}

	public Userinfo getJkr() {
		return jkr;
	}

	public void setJkr(Userinfo jkr) {
		this.jkr = jkr;
	}

	public RootactService getRootactservice() {
		return rootactservice;
	}

	public void setRootactservice(RootactService rootactservice) {
		this.rootactservice = rootactservice;
	}

	public List getLcrbuyinfo() {
		return lcrbuyinfo;
	}

	public void setLcrbuyinfo(List lcrbuyinfo) {
		this.lcrbuyinfo = lcrbuyinfo;
	}

	public List getBidList() {
		return BidList;
	}

	public void setBidList(List bidList) {
		BidList = bidList;
	}

	// public String findBidList(){
	// BidList=bidinfoservice.findAll();
	// return"findBidList";
	// }
	public List getFinance_bid_list() {
		return finance_bid_list;
	}

	public void setFinance_bid_list(List finance_bid_list) {
		this.finance_bid_list = finance_bid_list;
	}

	public Finplan getFinplan() {
		return finplan;
	}

	public void setFinplan(Finplan finplan) {
		this.finplan = finplan;
	}

	public List getHaveonbidlist() {
		return haveonbidlist;
	}

	public void setHaveonbidlist(List haveonbidlist) {
		this.haveonbidlist = haveonbidlist;
	}

	public List getWaitbidlist() {
		return waitbidlist;
	}

	public void setWaitbidlist(List waitbidlist) {
		this.waitbidlist = waitbidlist;
	}

	public Integer getA() {
		return a;
	}

	public void setA(Integer a) {
		this.a = a;
	}

	public BidinfoDAO getBidinfodao() {
		return bidinfodao;
	}

	public void setBidinfodao(BidinfoDAO bidinfodao) {
		this.bidinfodao = bidinfodao;
	}

	public List getAll_finance_list() {
		return all_finance_list;
	}

	public void setAll_finance_list(List all_finance_list) {
		this.all_finance_list = all_finance_list;
	}

	public List getFirstgonglist() {
		return firstgonglist;
	}

	public void setFirstgonglist(List firstgonglist) {
		this.firstgonglist = firstgonglist;
	}

	public List getFirstdonglist() {
		return firstdonglist;
	}

	public void setFirstdonglist(List firstdonglist) {
		this.firstdonglist = firstdonglist;
	}

	public NewsinfoService getNewsinfoservice() {
		return newsinfoservice;
	}

	public void setNewsinfoservice(NewsinfoService newsinfoservice) {
		this.newsinfoservice = newsinfoservice;
	}

	public UserinfoDAO getUserinfodao() {
		return userinfodao;
	}

	public void setUserinfodao(UserinfoDAO userinfodao) {
		this.userinfodao = userinfodao;
	}

	public RecordsDAO getRecordsdao() {
		return recordsdao;
	}

	public void setRecordsdao(RecordsDAO recordsdao) {
		this.recordsdao = recordsdao;
	}

	public CominfoDAO getCominfodao() {
		return cominfodao;
	}

	public void setCominfodao(CominfoDAO cominfodao) {
		this.cominfodao = cominfodao;
	}

	public List getAllfinancelist() {
		return allfinancelist;
	}

	public void setAllfinancelist(List allfinancelist) {
		this.allfinancelist = allfinancelist;
	}

	public List getJkrlist() {
		return jkrlist;
	}

	public void setJkrlist(List jkrlist) {
		this.jkrlist = jkrlist;
	}

	public List getBdsblist() {
		return bdsblist;
	}

	public void setBdsblist(List bdsblist) {
		this.bdsblist = bdsblist;
	}

	public List getRepayplan() {
		return repayplan;
	}

	public void setRepayplan(List repayplan) {
		this.repayplan = repayplan;
	}

	public List getFirsthuanlist() {
		return firsthuanlist;
	}

	public void setFirsthuanlist(List firsthuanlist) {
		this.firsthuanlist = firsthuanlist;
	}

	public List getFirstmeilist() {
		return firstmeilist;
	}

	public void setFirstmeilist(List firstmeilist) {
		this.firstmeilist = firstmeilist;
	}

	public List getGuacomlist() {
		return guacomlist;
	}

	public void setGuacomlist(List guacomlist) {
		this.guacomlist = guacomlist;
	}

	public String getGuacom() {
		return guacom;
	}

	public void setGuacom(String guacom) {
		this.guacom = guacom;
	}

	public String getUploader() {
		return uploader;
	}

	public void setUploader(String uploader) {
		this.uploader = uploader;
	}

	public List<File> getFile() {
		return file;
	}

	public void setFile(List<File> file) {
		this.file = file;
	}

	public List<String> getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(List<String> fileFileName) {
		this.fileFileName = fileFileName;
	}

	public List<String> getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(List<String> fileContentType) {
		this.fileContentType = fileContentType;
	}

}