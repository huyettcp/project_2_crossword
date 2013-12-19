/*

	CWORD JavaScript Crossword Engine

	Copyright (C) 2007-2010 Pavel Simakov
	http://www.softwaresecretweapons.com/jspwiki/cword

	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA

*/
function oygEndpoint(){this.cookie=oygNextRandomInt(),this.seq=0,this.oob=0,this.badcookie=0}function oygCompletionPort(t,e){this.endpoint=t,t.seq++,this.seq=t.seq,this.onError=null,this.onTimeout=null,this.onComplete=null,this.onDone=null,this.timeout=15e3,this.ajax=new JSONscriptRequest(e+"&seq="+this.seq+"&cookie="+t.cookie)}function oyServer(t,e,o){this.appHome=t,this.ns=e,this.canTalkToServer=o,this.ep=new oygEndpoint,this.md5=new oySign,this.trackSeq=0,this.trackURL=this.appHome+"/app/trackAction.php",this.submitURL=this.appHome+"/app/submitScore.php"}function oygSubmitScoreJSONComplete(t){var e=oygSubmitScoreCompletionPoint;if(null!=e)if(t.envelope.cookie==e.endpoint.cookie)if(t.envelope.seq==e.seq){var o=e.onComplete,i=e.onError;e.finit(),t.envelope.success?null!=o&&o(t.data):null!=i&&i(t.envelope.msg)}else e.endpoint.oob++;else e.endpoint.badcookie++;else oygEndpoint.noendpoint++}oygEndpoint.noendpoint=0,oygCompletionPort.prototype.init=function(){this.ajax.init();var t=this;this.timer=setTimeout(function(){var e=t.onTimeout;t.finit(),null!=e&&e()},this.timeout),this.ajax.submit()},oygCompletionPort.prototype.finit=function(){this.onError=null,this.onTimeout=null,this.onComplete=null,this.ajax.finit(),this.ajax=null,clearTimeout(this.timer),this.timer=null},oyServer.prototype.computeMatrix=function(t){for(var e=new function(){},o="",i="",n=0;n<t.length;n++)t[n].matched?(i+="1",o+=t[n].answer):i+="0";return e.states=i,e.concat=o,e},oyServer.prototype.trackAction=function(t,e){if(this.canTalkToServer&&null!=e){var o=escape(t),i="uid="+o+"&ns="+escape(this.ns)+"&verb="+escape(e),n=this.md5.hex_hmac_md5(o,i),s="data="+escape(i)+"&sign="+n+"&seq="+this.trackSeq,r=this.trackURL+"?"+s;document.getElementById("oygTrackAction").src=r,this.trackSeq++}},oyServer.prototype.submitScore=function(t,e,o,i,n,s,r,a,c,p){var u=e,h=this.computeMatrix(p),m=this.md5.hex_hmac_md5(u,h.concat),l="uid="+u+"&ns="+escape(this.ns)+"&states="+h.states+"&concat="+m+"&score="+o+"&deducts"+i+"&checks="+n+"&reveals="+s+"&matches="+r+"&time="+a+"&name="+escape(c),d=this.md5.hex_hmac_md5(u,l),y="uid="+u+"&data="+escape(l)+"&sign="+d,S=this.submitURL+"?"+y;this.submitScoreAjaxAnywhere(this.ep,t,S,r)},oyServer.prototype.submitScoreAjaxAnywhere=function(t,e,o,i){var n=e,s=new oygCompletionPort(t,o);s.onComplete=function(t){n.scoreSubmittedMatches=i,n.rank=t.rank,n.invalidateMenu(),n.footer.stateOk("Score submitted!")},s.onTimeout=function(){n.footer.stateError("Timeout waiting for server to reply!"),alert("Failed to submit score. Server didn't reply!")},s.onError=function(t){n.footer.stateError("Failed to submit score!"),alert("Failed to submit score. Server replied with:\n\n"+t)},oygSubmitScoreCompletionPoint=s,s.init()};var oygSubmitScoreCompletionPoint;