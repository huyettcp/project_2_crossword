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
function oyCrosswordClue(t,s,e,i,l,o,n){this.len=t,this.clue=s,this.answer=e,this.sign=i,this.dir=l,this.xpos=o,this.ypos=n,this.revealed=!1,this.matched=!1}function oyClueList(t,s,e,i){this.puzz=t,this.name=s,this.clues=e,this.ns=i,this.selIdx=-1}oyCrosswordClue.prototype.completed=function(){return this.matched||this.revealed},oyClueList.prototype.render=function(){var t=this.name;t+="<table class='oyList' border='0' cellspacing='0' cellpadding='0'>";for(var s=0;s<this.clues.length;s++)0!=s&&(t+="<tr class='oyListSpacer'><td></td></tr>"),t+="<tr><td class='oyListNormal' id='"+this.ns+s+"'><b>"+(s+1)+".</b> "+this.clues[s].clue+"</td></tr>";return t+="</table>"},oyClueList.prototype.bind=function(){for(var t=0;t<this.clues.length;t++){var s=document.getElementById(this.ns+t);this.bindItem(s,t)}},oyClueList.prototype.unbind=function(){for(var t=0;t<this.clues.length;t++){var s=document.getElementById(this.ns+t);s.onclick=null}},oyClueList.prototype.bindItem=function(t,s){var e=this;t.onclick=function(){e.clickItem(s)}},oyClueList.prototype.clickItem=function(t){this.selectItem(t),this.puzz.unfocusOldCell(),this.puzz.focusNewCell(this.clues[t].xpos,this.clues[t].ypos,!0,this.clues[t])},oyClueList.prototype.selectItem=function(t){-1!=this.selIdx&&(document.getElementById(this.ns+this.selIdx).className="oyListNormal"),-1!=t&&(document.getElementById(this.ns+t).className="oyListSel"),this.selIdx=t},oyClueList.prototype.getClueIndexForPoint=function(t,s){for(var e=0;e<this.clues.length;e++)if(0==this.clues[e].dir){if(s==this.clues[e].ypos&&t>=this.clues[e].xpos&&t<this.clues[e].xpos+this.clues[e].len)return e}else if(t==this.clues[e].xpos&&s>=this.clues[e].ypos&&s<this.clues[e].ypos+this.clues[e].len)return e;return-1};