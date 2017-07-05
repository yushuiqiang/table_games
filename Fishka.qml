import QtQuick 2.0

Item {
    property int p_ind: drop_link.p_ind
    property int index: 0
    property int dddindex: 0
    property int fiska_size: 106
    property var drop_link: null
    property string image_white: "1w.png"
    property string image_black: "1b.png"

    id:delegateRoot
    width: fiska_size
    height: fiska_size


    anchors.horizontalCenter: drop_link.horizontalCenter
    anchors.top: drop_link.rotation!=180?drop_link.top:undefined
    anchors.bottom: drop_link.rotation==180?drop_link.bottom:undefined
    //rotation: drop_link.rotation
    anchors.topMargin: drop_link.rotation!=180?fiska_size*index:0
    anchors.bottomMargin: drop_link.rotation==180?fiska_size*index:0
    //anchors.verticalCenter: parent.verticalCenter
    Image{
        id:delegate_image
        anchors.fill: parent
        source: gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
    }
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: 35
    Drag.hotSpot.y: 35
    Drag.dragType: Drag.Internal
    //Drag.dragType: Drag.Automatic
    Drag.supportedActions: Qt.CopyAction
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        drag.smoothed:true
        enabled: false
        onPressed: {
            global_area.hoverEnabled=false
            gameLogic.drag_row_index=p_ind;
            main_form.drag_item=drag.target;
            main_form.drag_need_resume=false;
        }
        onReleased: {
            if(parent.Drag.target==null){
                console.log("draging:"+main_form.drag_item)
                var obj=main_form;
                while(obj!=null){
                    obj=obj.childAt(main_form.drag_item.x+(delegateRoot.width/2),main_form.drag_item.y+(delegateRoot.height/2));
                    console.log("child:"+obj)
                }
                global_area.hoverEnabled=true
                main_form.drag_need_resume=true
                console.log("drop reseted")
                return;
            }
            global_area.hoverEnabled=false
            main_form.drag_item=null;
            main_form.drag_need_resume=false
            console.log("parent.Drag.target:"+ parent.Drag.target)
            var ret = parent.Drag.drop()
            console.log("drop result:" + ret)
            //row_repeater.updateModel();

        }
    }
    states: [State {
            when: dragArea.drag.active
            AnchorChanges {
                target: delegateRoot;
                anchors.verticalCenter: undefined;
                anchors.horizontalCenter: undefined;
                anchors.top:undefined;
                anchors.bottom: undefined;
            }
        }]
    Component.onCompleted: {
        //console.log("Component.onCompleted",p_ind,index,gameLogic.get_count(p_ind));
        this.objectName=p_ind+"x"+index
        main_form.newgamestate.connect(delegateRoot.updateDrag)
        dddindex=main_form.fishka_count++
        //main_form.fishka_count++
    }
    function updateDrag(state) {
//        try {
//            if(!(index)||null)return;
//        } catch (e) {
//            console.log(e)
//            return
//        }
        //if(!(index)||null)return;
        console.log("onGamestateChanged",p_ind,index,gameLogic.get_count(p_ind));
        dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
        delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        //console.log("onGamestateChanged",state,index,gameLogic.get_count(p_ind),enabled);
    }
    onIndexChanged: {
        console.log("onIndexChanged",p_ind,index,gameLogic.get_count(p_ind));
        //dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        delegateRoot.updateDrag(gameLogic.logic_state)
    }
    onDrop_linkChanged: {
        //dragArea.enabled=gameLogic.get_count(p_ind)-1==index&&gameLogic.can_drag_fishka(p_ind);
        //delegate_image.source=gameLogic.get_color(p_ind)==0?"./img/"+image_white:"./img/"+image_black
        delegateRoot.updateDrag(gameLogic.logic_state)
    }
    onXChanged: {
        gameLogic.setFishkaPos(gameLogic.translateToCanvas(x,y),dddindex);
    }
}
