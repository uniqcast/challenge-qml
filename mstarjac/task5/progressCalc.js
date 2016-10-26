
function getStart(start){
    var startHours = start.split(':')[0];
    var startMinutes = start.split(':')[1];

    var st = new Date;
    st.setHours(startHours)
    st.setMinutes(startMinutes)

    return st.getTime()
}

function getEnd(end){
    var endHours = end.split(':')[0];
    var endMinutes = end.split(':')[1];

    var et = new Date;
    et.setHours(endHours)
    et.setMinutes(endMinutes)

    return et.getTime()
}
