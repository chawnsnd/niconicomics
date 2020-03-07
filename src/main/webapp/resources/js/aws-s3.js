var albumBucketName = 'niconicomics-images';
var bucketRegion = 'ap-northeast-2';
var IdentityPoolId = 'ap-northeast-2:0ec1a724-7e84-44a4-8498-e9543e383104';

AWS.config.update({
  region: bucketRegion,
  credentials: new AWS.CognitoIdentityCredentials({
    IdentityPoolId: IdentityPoolId
  })
});

var s3 = new AWS.S3({
  apiVersion: '2006-03-01',
  params: {Bucket: albumBucketName}
});

var imageType = ['image/png', 'image/gif', 'image/jpeg', 'image/bmp', 'image/x-icon'];

function getCurrentTime() {
    function pad2(n) {
        return n < 10 ? '0' + n : n
    }
    var now = new Date();
    return now.getFullYear().toString() + pad2(now.getMonth() + 1) + pad2(now.getDate()) + pad2(now.getHours()) + pad2(now.getMinutes()) + pad2(now.getSeconds()) + pad2(now.getMilliseconds());
}

function uploadImage(path, file) {
    return new Promise((resolve, reject) => {
        file = file[0].files[0];
        if(imageType.indexOf(file.type)==-1){
            reject('It is not image file');
        }
        var fileExt = file.name.substr(file.name.lastIndexOf('.')+1);
        var key = `${path}/${getCurrentTime()}.${fileExt}`;
        uploadS3(key, file)
        .then(resolve)
        .catch(reject);
    });
}

function uploadImages(path, files) {
    return new Promise((resolve, reject) => {
        files.map((idx, file) => {
            file = file.files[0];
            if(imageType.indexOf(file.type)==-1){
                reject('There is no image file');
            }
        });
        Promise
        .all(files.map((idx, file) => {
            file = file.files[0];
            var fileExt = file.name.substr(file.name.lastIndexOf('.')+1);
            var key = `${path}/${getCurrentTime()}.${fileExt}`;
            return uploadS3(key, file);
        }))
        .then(resolve)
        .catch(reject)
    });
}

function uploadS3(key ,file){
    return new Promise((resolve, reject) => {
        s3.upload({
            Key: key,
            Body: file,
            ACL: 'public-read'
        }, function(err, data) {
            if (err){
                reject('There was an error uploading your image: '+err.message);
            }else{
                resolve(data);
            }
        });
    })
}

function deleteImage(key) {
    return new Promise((resolve, reject) => {
        s3.deleteObject({Key: key}, function(err, data) {
            if (err) {
                reject('There was an error deleting your image: '+err.message);
            }else{
                resolve('Successfully deleted image: ' + data);
            }
        });
    })
}

function modifyImage(key, file){
    var path = key.substr(0, key.lastIndexOf("/"));
    return new Promise((resolve, reject) => {
        deleteImage(key)
        .catch(reject);
        uploadImage(path, file)
        .then(resolve)
        .catch(reject);
    })
}