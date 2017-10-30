function getPosition(start, end) {
    var d = new Date()
    var startMin = Number(start.split(':')[0])*60 + Number(start.split(':')[1])
    var endMin = Number(end.split(':')[0])*60 + Number(end.split(':')[1])
    var minutes = d.getMinutes() + d.getHours()*60
    return progress.width = progressParent.width*((minutes-startMin)/(endMin-startMin))
}

