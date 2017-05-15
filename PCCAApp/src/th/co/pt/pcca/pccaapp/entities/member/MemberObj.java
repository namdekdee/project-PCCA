package th.co.pt.pcca.pccaapp.entities.member;

import java.util.List;

import th.co.pt.pcca.pccaapp.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MoveMentObj;

public class MemberObj {
     public String since_date ;
     public String since_date_en ;
     public String groupmenu_code ;
     public String lang ;
     public String title ;
     public List<MainMenuObj> mainmenu ;
     public List<MainMenuObj> sitemap ;
     public List<MoveMentObj> movement;
     public String password;
     public String codempid;
     public String codtitle;
     public String namempt;
     public String namempe;
     public String codsex;
     public String staemp;
     public String stamarry;
     public String stamilit;
     public String codcomp;
     public String namcenteng;
     public String namcenttha;
     public String codpos;
     public String nampose;
     public String nampost;
     public String dteempdb;
     public String dteempmt;
     public String codempmt;
     public String namempme;
     public String namempmt;
     public String codjob;
     public String jobname;
     public String jobnamt;
     public String numappl;
     public int numlvl;
     public String typpayroll;
     public String typpayrollname;
     public String typpayrollnamt;
     public String typemp;
     public String typempname;
     public String typempnamt;
     public String flgatten;
     public String codbrlc;
     public String locatione;
     public String locationt;
     public String numtelof;
     public String email;
     public String codcalen;
     public String worknamee;
     public String worknamet;
     public String dteefpos;
     public String dteeflvl;
     public String dteeffex;
     public String dteduepr;
     public String dteoccup;
     public String dtereemp;
     public String codorgin;
     public String originname;
     public String originnamt;
     public String codnatnl;
     public String nationname;
     public String nationnamt;
     public String codrelgn;
     public String regionname;
     public String regionnamt;
     public String codedlv;
     public String codedlvname;
     public String codedlvnamt;
     public String codmajsb;
     public String codmajsbname;
     public String codmajsbnamt;
     public String codblood;
     public int weight;
     public int high;
     public String numoffid;
     public String codbank;
     public String namebanke;
     public String namebankt;
     public String numbank;
     public String numtaxid;
     public String numsaid;
     public String flgtax;
     public String typtax;
     public int qtychedu;
     public int qtychned;
     public int qtywork;
     public int ages;
     public int age_level;
     public int age_pos;
     public String update_date;
     public String update_by;
     public String create_date;
     public String create_by;

     public int numminlvl;
     public int nummaxlvl;
     public String gu_id;
     public int case_permiss;
     public String savep;
 	public String editp;
 	public String deletep;
 	public String addp;
 	public String approve_flg;
 	public String head_flg;
 	public String leader_name;
	public int age_year;
	public int age_month;
	public int qtywork_year;
	public int qtywork_month;
	public String status_desc;
	public String year;
	public String page_default;
	public void setSince_date(String since_date) {
		this.since_date = since_date;
	}
	public String getSince_date_en() {
		return since_date_en;
	}
	public void setSince_date_en(String since_date_en) {
		this.since_date_en = since_date_en;
	}
	public String getGroupmenu_code() {
		return groupmenu_code;
	}
	public void setGroupmenu_code(String groupmenu_code) {
		this.groupmenu_code = groupmenu_code;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public List<MainMenuObj> getMainmenu() {
		return mainmenu;
	}
	public void setMainmenu(List<MainMenuObj> mainmenu) {
		this.mainmenu = mainmenu;
	}
	public List<MainMenuObj> getSitemap() {
		return sitemap;
	}
	public void setSitemap(List<MainMenuObj> sitemap) {
		this.sitemap = sitemap;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCodempid() {
		return codempid;
	}
	public void setCodempid(String codempid) {
		this.codempid = codempid;
	}
	public String getCodtitle() {
		return codtitle;
	}
	public void setCodtitle(String codtitle) {
		this.codtitle = codtitle;
	}
	public String getNamempt() {
		return namempt;
	}
	public void setNamempt(String namempt) {
		this.namempt = namempt;
	}
	public String getNamempe() {
		return namempe;
	}
	public void setNamempe(String namempe) {
		this.namempe = namempe;
	}
	public String getCodsex() {
		return codsex;
	}
	public void setCodsex(String codsex) {
		this.codsex = codsex;
	}
	public String getStaemp() {
		return staemp;
	}
	public void setStaemp(String staemp) {
		this.staemp = staemp;
	}
	public String getStamarry() {
		return stamarry;
	}
	public void setStamarry(String stamarry) {
		this.stamarry = stamarry;
	}
	public String getStamilit() {
		return stamilit;
	}
	public void setStamilit(String stamilit) {
		this.stamilit = stamilit;
	}
	public String getCodcomp() {
		return codcomp;
	}
	public void setCodcomp(String codcomp) {
		this.codcomp = codcomp;
	}
	public String getNamcenteng() {
		return namcenteng;
	}
	public void setNamcenteng(String namcenteng) {
		this.namcenteng = namcenteng;
	}
	public String getNamcenttha() {
		return namcenttha;
	}
	public void setNamcenttha(String namcenttha) {
		this.namcenttha = namcenttha;
	}
	public String getCodpos() {
		return codpos;
	}
	public void setCodpos(String codpos) {
		this.codpos = codpos;
	}
	public String getNampose() {
		return nampose;
	}
	public void setNampose(String nampose) {
		this.nampose = nampose;
	}
	public String getNampost() {
		return nampost;
	}
	public void setNampost(String nampost) {
		this.nampost = nampost;
	}
	public String getDteempdb() {
		return dteempdb;
	}
	public void setDteempdb(String dteempdb) {
		this.dteempdb = dteempdb;
	}
	public String getDteempmt() {
		return dteempmt;
	}
	public void setDteempmt(String dteempmt) {
		this.dteempmt = dteempmt;
	}
	public String getCodempmt() {
		return codempmt;
	}
	public void setCodempmt(String codempmt) {
		this.codempmt = codempmt;
	}
	public String getNamempme() {
		return namempme;
	}
	public void setNamempme(String namempme) {
		this.namempme = namempme;
	}
	public String getNamempmt() {
		return namempmt;
	}
	public void setNamempmt(String namempmt) {
		this.namempmt = namempmt;
	}
	public String getCodjob() {
		return codjob;
	}
	public void setCodjob(String codjob) {
		this.codjob = codjob;
	}
	public String getJobname() {
		return jobname;
	}
	public void setJobname(String jobname) {
		this.jobname = jobname;
	}
	public String getJobnamt() {
		return jobnamt;
	}
	public void setJobnamt(String jobnamt) {
		this.jobnamt = jobnamt;
	}
	public String getNumappl() {
		return numappl;
	}
	public void setNumappl(String numappl) {
		this.numappl = numappl;
	}
	public int getNumlvl() {
		return numlvl;
	}
	public void setNumlvl(int numlvl) {
		this.numlvl = numlvl;
	}
	public String getTyppayroll() {
		return typpayroll;
	}
	public void setTyppayroll(String typpayroll) {
		this.typpayroll = typpayroll;
	}
	public String getTyppayrollname() {
		return typpayrollname;
	}
	public void setTyppayrollname(String typpayrollname) {
		this.typpayrollname = typpayrollname;
	}
	public String getTyppayrollnamt() {
		return typpayrollnamt;
	}
	public void setTyppayrollnamt(String typpayrollnamt) {
		this.typpayrollnamt = typpayrollnamt;
	}
	public String getTypemp() {
		return typemp;
	}
	public void setTypemp(String typemp) {
		this.typemp = typemp;
	}
	public String getTypempname() {
		return typempname;
	}
	public void setTypempname(String typempname) {
		this.typempname = typempname;
	}
	public String getTypempnamt() {
		return typempnamt;
	}
	public void setTypempnamt(String typempnamt) {
		this.typempnamt = typempnamt;
	}
	public String getFlgatten() {
		return flgatten;
	}
	public void setFlgatten(String flgatten) {
		this.flgatten = flgatten;
	}
	public String getCodbrlc() {
		return codbrlc;
	}
	public void setCodbrlc(String codbrlc) {
		this.codbrlc = codbrlc;
	}
	public String getLocatione() {
		return locatione;
	}
	public void setLocatione(String locatione) {
		this.locatione = locatione;
	}
	public String getLocationt() {
		return locationt;
	}
	public void setLocationt(String locationt) {
		this.locationt = locationt;
	}
	public String getNumtelof() {
		return numtelof;
	}
	public void setNumtelof(String numtelof) {
		this.numtelof = numtelof;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCodcalen() {
		return codcalen;
	}
	public void setCodcalen(String codcalen) {
		this.codcalen = codcalen;
	}
	public String getWorknamee() {
		return worknamee;
	}
	public void setWorknamee(String worknamee) {
		this.worknamee = worknamee;
	}
	public String getWorknamet() {
		return worknamet;
	}
	public void setWorknamet(String worknamet) {
		this.worknamet = worknamet;
	}
	public String getDteefpos() {
		return dteefpos;
	}
	public void setDteefpos(String dteefpos) {
		this.dteefpos = dteefpos;
	}
	public String getDteeflvl() {
		return dteeflvl;
	}
	public void setDteeflvl(String dteeflvl) {
		this.dteeflvl = dteeflvl;
	}
	public String getDteeffex() {
		return dteeffex;
	}
	public void setDteeffex(String dteeffex) {
		this.dteeffex = dteeffex;
	}
	public String getDteduepr() {
		return dteduepr;
	}
	public void setDteduepr(String dteduepr) {
		this.dteduepr = dteduepr;
	}
	public String getDteoccup() {
		return dteoccup;
	}
	public void setDteoccup(String dteoccup) {
		this.dteoccup = dteoccup;
	}
	public String getDtereemp() {
		return dtereemp;
	}
	public void setDtereemp(String dtereemp) {
		this.dtereemp = dtereemp;
	}
	public String getCodorgin() {
		return codorgin;
	}
	public void setCodorgin(String codorgin) {
		this.codorgin = codorgin;
	}
	public String getOriginname() {
		return originname;
	}
	public void setOriginname(String originname) {
		this.originname = originname;
	}
	public String getOriginnamt() {
		return originnamt;
	}
	public void setOriginnamt(String originnamt) {
		this.originnamt = originnamt;
	}
	public String getCodnatnl() {
		return codnatnl;
	}
	public void setCodnatnl(String codnatnl) {
		this.codnatnl = codnatnl;
	}
	public String getNationname() {
		return nationname;
	}
	public void setNationname(String nationname) {
		this.nationname = nationname;
	}
	public String getNationnamt() {
		return nationnamt;
	}
	public void setNationnamt(String nationnamt) {
		this.nationnamt = nationnamt;
	}
	public String getCodrelgn() {
		return codrelgn;
	}
	public void setCodrelgn(String codrelgn) {
		this.codrelgn = codrelgn;
	}
	public String getRegionname() {
		return regionname;
	}
	public void setRegionname(String regionname) {
		this.regionname = regionname;
	}
	public String getRegionnamt() {
		return regionnamt;
	}
	public void setRegionnamt(String regionnamt) {
		this.regionnamt = regionnamt;
	}
	public String getCodedlv() {
		return codedlv;
	}
	public void setCodedlv(String codedlv) {
		this.codedlv = codedlv;
	}
	public String getCodedlvname() {
		return codedlvname;
	}
	public void setCodedlvname(String codedlvname) {
		this.codedlvname = codedlvname;
	}
	public String getCodedlvnamt() {
		return codedlvnamt;
	}
	public void setCodedlvnamt(String codedlvnamt) {
		this.codedlvnamt = codedlvnamt;
	}
	public String getCodmajsb() {
		return codmajsb;
	}
	public void setCodmajsb(String codmajsb) {
		this.codmajsb = codmajsb;
	}
	public String getCodmajsbname() {
		return codmajsbname;
	}
	public void setCodmajsbname(String codmajsbname) {
		this.codmajsbname = codmajsbname;
	}
	public String getCodmajsbnamt() {
		return codmajsbnamt;
	}
	public void setCodmajsbnamt(String codmajsbnamt) {
		this.codmajsbnamt = codmajsbnamt;
	}
	public String getCodblood() {
		return codblood;
	}
	public void setCodblood(String codblood) {
		this.codblood = codblood;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public int getHigh() {
		return high;
	}
	public void setHigh(int high) {
		this.high = high;
	}
	public String getNumoffid() {
		return numoffid;
	}
	public void setNumoffid(String numoffid) {
		this.numoffid = numoffid;
	}
	public String getCodbank() {
		return codbank;
	}
	public void setCodbank(String codbank) {
		this.codbank = codbank;
	}
	public String getNamebanke() {
		return namebanke;
	}
	public void setNamebanke(String namebanke) {
		this.namebanke = namebanke;
	}
	public String getNamebankt() {
		return namebankt;
	}
	public void setNamebankt(String namebankt) {
		this.namebankt = namebankt;
	}
	public String getNumbank() {
		return numbank;
	}
	public void setNumbank(String numbank) {
		this.numbank = numbank;
	}
	public String getNumtaxid() {
		return numtaxid;
	}
	public void setNumtaxid(String numtaxid) {
		this.numtaxid = numtaxid;
	}
	public String getNumsaid() {
		return numsaid;
	}
	public void setNumsaid(String numsaid) {
		this.numsaid = numsaid;
	}
	public String getFlgtax() {
		return flgtax;
	}
	public void setFlgtax(String flgtax) {
		this.flgtax = flgtax;
	}
	public String getTyptax() {
		return typtax;
	}
	public void setTyptax(String typtax) {
		this.typtax = typtax;
	}
	public int getQtychedu() {
		return qtychedu;
	}
	public void setQtychedu(int qtychedu) {
		this.qtychedu = qtychedu;
	}
	public int getQtychned() {
		return qtychned;
	}
	public void setQtychned(int qtychned) {
		this.qtychned = qtychned;
	}
	public int getQtywork() {
		return qtywork;
	}
	public void setQtywork(int qtywork) {
		this.qtywork = qtywork;
	}
	public int getAges() {
		return ages;
	}
	public void setAges(int ages) {
		this.ages = ages;
	}
	public int getAge_level() {
		return age_level;
	}
	public void setAge_level(int age_level) {
		this.age_level = age_level;
	}
	public int getAge_pos() {
		return age_pos;
	}
	public void setAge_pos(int age_pos) {
		this.age_pos = age_pos;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public String getUpdate_by() {
		return update_by;
	}
	public void setUpdate_by(String update_by) {
		this.update_by = update_by;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getCreate_by() {
		return create_by;
	}
	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}
	public String getSince_date() {
		return since_date;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public int getNumminlvl() {
		return numminlvl;
	}
	public void setNumminlvl(int numminlvl) {
		this.numminlvl = numminlvl;
	}
	public int getNummaxlvl() {
		return nummaxlvl;
	}
	public void setNummaxlvl(int nummaxlvl) {
		this.nummaxlvl = nummaxlvl;
	}
	public String getGu_id() {
		return gu_id;
	}
	public void setGu_id(String gu_id) {
		this.gu_id = gu_id;
	}
	public int getCase_permiss() {
		return case_permiss;
	}
	public void setCase_permiss(int case_permiss) {
		this.case_permiss = case_permiss;
	}
	public String getSavep() {
		return savep;
	}
	public void setSavep(String savep) {
		this.savep = savep;
	}
	public String getEditp() {
		return editp;
	}
	public void setEditp(String editp) {
		this.editp = editp;
	}
	public String getDeletep() {
		return deletep;
	}
	public void setDeletep(String deletep) {
		this.deletep = deletep;
	}
	public String getAddp() {
		return addp;
	}
	public void setAddp(String addp) {
		this.addp = addp;
	}
	public String getApprove_flg() {
		return approve_flg;
	}
	public void setApprove_flg(String approve_flg) {
		this.approve_flg = approve_flg;
	}
	public String getHead_flg() {
		return head_flg;
	}
	public void setHead_flg(String head_flg) {
		this.head_flg = head_flg;
	}
	public String getLeader_name() {
		return leader_name;
	}
	public void setLeader_name(String leader_name) {
		this.leader_name = leader_name;
	}
	public int getAge_year() {
		return age_year;
	}
	public void setAge_year(int age_year) {
		this.age_year = age_year;
	}
	public int getAge_month() {
		return age_month;
	}
	public void setAge_month(int age_month) {
		this.age_month = age_month;
	}
	public int getQtywork_year() {
		return qtywork_year;
	}
	public void setQtywork_year(int qtywork_year) {
		this.qtywork_year = qtywork_year;
	}
	public int getQtywork_month() {
		return qtywork_month;
	}
	public void setQtywork_month(int qtywork_month) {
		this.qtywork_month = qtywork_month;
	}
	public String getStatus_desc() {
		return status_desc;
	}
	public void setStatus_desc(String status_desc) {
		this.status_desc = status_desc;
	}
	public List<MoveMentObj> getMovement() {
		return movement;
	}
	public void setMovement(List<MoveMentObj> movement) {
		this.movement = movement;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPage_default() {
		return page_default;
	}
	public void setPage_default(String page_default) {
		this.page_default = page_default;
	}
	
    
}
