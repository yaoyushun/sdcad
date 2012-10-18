function checkmail(mail){ 
 var strr;
 re=/(\w+@\w+\.\w+)(\.{0,1}\w*)(\.{0,1}\w*)/i;
 re.exec(mail);
 if (RegExp.$3!=""&&RegExp.$3!="."&&RegExp.$2!="."){
     strr=RegExp.$1+RegExp.$2+RegExp.$3;
  }else{
     if (RegExp.$2!=""&&RegExp.$2!=".") strr=RegExp.$1+RegExp.$2;
     else  strr=RegExp.$1 ;
  }
 if (strr!=mail) {
     alert("\请填写正确的邮件地址");
     return false ;
 };
  return true;
 };
document.write("<table width='100%' border='0' cellspacing='0' cellpadding='0'>");document.write("<form onsubmit='return checkmail(maillist.email.value)' name='maillist' method='post' action='/_maillist/submit.php'>");document.write("<tr><td align=left><input type='text' size='20' name='email' value='请填邮件地址'>");document.write("<input type='submit' name='add' value='订阅'><input type='submit' name='remove' value='退订'></td></tr>");document.write("</form></table>");