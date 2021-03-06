import QtQuick 2.0

Item {
    property int main_user: 0
    property int second_user: 0
    property int board_mode: 0
    property int user_id: 0
    property int second_user_id: 0
    property int user_balance: 0
    property int user_pay_selected: 0
    id: item1
    width: 1280
    height: 1024

    Menu1x_ {
        id: menu1x_1
        rotation: 180
        index:1
    }

    Menu1x_ {
        id: menu1x_2
        y: 0
        anchors.left: menu1x_1.right
        anchors.leftMargin: 0
        index:2
    }
    ListModel {
        id:mainGameList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
            }
            this.set(ind,{"selected":true});
        }
        function setMultiSelected(ind){
            this.set(ind,{"selected":!this.get(ind).selected});
        }
        ListElement {
            num: 1
            selected:false
            width:137
            height:50
            img: "img/menu/n.png"
            img_: "img/menu/n_.png"
            caption:"НАРДЫ"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            width:157
            height:50
            img: "img/menu/shs.png"
            img_: "img/menu/shs_.png"
            caption:"ШАХМАТЫ"
            enable:true
        }

        ListElement {
            num: 3
            selected:false
            width:137
            height:50
            img: "img/menu/sh.png"
            img_: "img/menu/sh_.png"
            caption:"ШАШКИ"
            enable:true
        }
    }

    ListModel {
        id:mainGameTypeList
        function setSelected(ind){
            if(ind!=0)return;
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
            }
            this.set(ind,{"selected":true});
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ТРЕНИРОВКА"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МАТЧ"
            enable:true
        }
    }

    ListModel {
        id:mainGameTimeList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
            }
            this.set(ind,{"selected":true});
            if(user_balance>=parseInt(this.get(ind).caption))user_pay_selected=parseInt(this.get(ind).caption);
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/15.png"
            img_: "img/menu/btn_.png"
            caption:"500"
            enable:false
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/30.png"
            img_: "img/menu/btn_.png"
            caption:"1000"
            enable:false
        }
        ListElement {
            num: 3
            selected:false
            img: "img/menu/45.png"
            img_: "img/menu/btn_.png"
            caption:"1500"
            enable:false
        }
        ListElement {
            num: 4
            selected:false
            img: "img/menu/60.png"
            img_: "img/menu/btn_.png"
            caption:"2000"
            enable:false
        }
        ListElement {
            num: 5
            selected:false
            img: "img/menu/00.png"
            img_: "img/menu/btn_.png"
            caption:"10000"
            enable:false
        }
    }


    ListModel {
        id:mainGameStyleList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
            }
            this.set(ind,{"selected":true});
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ДЕРЕВО"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"КАМЕНЬ"
            enable:true
        }

        ListElement {
            num: 3
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"МЕТАЛЛ"
            enable:true
        }
    }
    ListModel {
        id:mainGameHerroStyleList
        function setSelected(ind){
            for(var i=0;i<this.count;i++){
                this.set(i,{"selected":false})
                //secondGameStyleList.set(i,{"enable":false,"selected":false})
            }
            this.set(ind,{"selected":true});
            //secondGameStyleList.set(ind,{"enable":false,"selected":true})
        }
        ListElement {
            num: 1
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"АРАБСКИЙ"
            enable:true
        }

        ListElement {
            num: 2
            selected:false
            img: "img/menu/btn.png"
            img_: "img/menu/btn_.png"
            caption:"ЕВРОПЕЙСКИЙ"
            enable:true
        }
    }


    Image {
        id: image
        height: 1024
        width: 30
        y:0
        x:625
        source: "img/menu/seredka.png"
    }
    Connections{
        target: main_win
        onHaveBill:{
            user_balance+=parseInt(bill);
            for(var i=0;i<mainGameTimeList.count;i++){
                if(parseInt(mainGameTimeList.get(i).caption)<=user_balance){
                    mainGameTimeList.set(i,{"enable":true})
                    mainGameTimeList.setSelected(i);
                }else{
                    mainGameTimeList.set(i,{"enable":false})
                }
            }
        }
    }

    function setGemeboardMode(mode){
        board_mode=mode;
        if(mode==1){
            menu1x_1.state="menu_offline"
            menu1x_2.state="menu_offline"
            second_user=3-main_user;
            mainGameList.setSelected(0);
            mainGameTypeList.setSelected(0);
            mainGameStyleList.setSelected(0);
            mainGameHerroStyleList.setSelected(0);
        }
    }
    function generateUUID () { // Public Domain/MIT
        var d = new Date().getTime();
        if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
            d += performance.now(); //use high-precision timer if available
        }
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
            var r = (d + Math.random() * 16) % 16 | 0;
            d = Math.floor(d / 16);
            return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
        });
    }

    function userLogin(ind,name){
        if(ind==1)menu1x_1.user_name=name
        if(ind==2)menu1x_2.user_name=name
        if(board_mode==1){
            if(main_user==ind){

                console.time('t');
                console.log(generateUUID());
                console.timeEnd('t');
            }else{
                if(second_user==1&&menu1x_2.state=="menu6"){
                    startGame(0,0,0);
                }
                if(second_user==2&&menu1x_1.state=="menu6"){
                    startGame(0,0,0);
                }
            }
        }
    }
    function have_player(ind){
        if(main_user==0){
            //TODO: clean lists
            main_user=ind;
        }else
            second_user=ind;
    }
    function leave_player(ind){
        //console.log("leave_player",main_user,second_user)
        if(main_user==ind){
            if(second_user!=0&&menu1x_1.state!="menu1"&&menu1x_1.state!="menu2"){
                main_user=second_user;
                second_user=0;
//                for(var i=0;i<mainGameList.count;i++){
//                    mainGameList.set(i,{"selected":secondGameList.get(i).selected})
//                    //secondGameList.set(i,{"enable":false,"selected":false})
//                }
//                for(var i=0;i<mainGameTypeList.count;i++){
//                    mainGameTypeList.set(i,{"selected":secondGameTypeList.get(i).selected})
//                    //secondGameTypeList.set(i,{"enable":false,"selected":false})
//                }
//                for(var i=0;i<mainGameTimeList.count;i++){
//                    mainGameTimeList.set(i,{"selected":secondGameTimeList.get(i).selected})
//                    //secondGameTimeList.set(i,{"enable":false,"selected":false})
//                }
//                for(var i=0;i<mainGameStyleList.count;i++){
//                    mainGameStyleList.set(i,{"selected":secondGameStyleList.get(i).selected})
//                    //secondGameStyleList.set(i,{"enable":false,"selected":false})
//                }
                listUpdated();
                if(main_user==1)menu1x_2.state="menu2"
                if(main_user==2)menu1x_1.state="menu2"
            }else{
                menu1x_1.state="menu1"
                menu1x_2.state="menu1"
                main_user=0;
                board_mode=0;
            }
        }else{
            //            menu1x_1.state="menu1"
            //            menu1x_2.state="menu1"
            //            second_user=0;
            //            board_mode=0;
        }
    }
    function listUpdated(){
//        for(var i=0;i<mainGameList.count;i++){
//            secondGameList.set(i,{"enable":mainGameList.get(i).selected})
//        }
//        for(var i=0;i<mainGameTypeList.count;i++){
//            secondGameTypeList.set(i,{"enable":mainGameTypeList.get(i).selected})
//        }
//        for(var i=0;i<mainGameTimeList.count;i++){
//            secondGameTimeList.set(i,{"enable":mainGameTimeList.get(i).selected})
//        }
//        for(var i=0;i<mainGameStyleList.count;i++){
//            secondGameStyleList.set(i,{"enable":mainGameStyleList.get(i).selected})
//        }
//        menu1x_1.updateList()
//        menu1x_2.updateList()
    }
    function checkCanStart(){
        if(mainGameList.get(0).selected&&mainGameTypeList.get(0).selected&&user_balance>=user_pay_selected&&user_balance>0&&user_pay_selected>0)return true
        return false;
    }
    function canStartGame(){
        if(board_mode==1&&checkCanStart()){
            if(second_user==1&&menu1x_1.state!="menu1"&&menu1x_1.state!="menu2"){
                startGame(0,0,0);
                return true;
            }
            if(second_user==2&&menu1x_2.state!="menu1"&&menu1x_2.state!="menu2"){
                startGame(0,0,0);
                return true;
            }
        }
        return false
    }

}
