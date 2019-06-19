function getTime(argTime) {
    var hours = argTime.split(':')[0];
    var minutes = argTime.split(':')[1];

    hours = parseInt(hours) * 3600
    minutes = parseInt(minutes) * 60
    var resultDate = hours + minutes

    return resultDate
}

