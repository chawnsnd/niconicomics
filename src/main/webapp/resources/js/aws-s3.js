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

function uploadImage(path, file) {
    return new Promise((resolve, reject) => {
        path = path.substr(1, path.length-1);
        file = file[0].files[0];
        var fileExt = file.name.substr(file.name.lastIndexOf('.')+1);
        var key = path+"/"+getCurrentTime()+"."+fileExt;
        uploadS3(key, file)
        .then(resolve)
        .catch(reject);
    });
}
function uploadImages(path, files) {
    return new Promise((resolve, reject) => {
    	path = path.substr(1, path.length-1);
    	var currentTime = getCurrentTime();
        Promise
        .all(files.map((idx,file) =>{
            file = file.files[0];
            var fileExt = file.name.substr(file.name.lastIndexOf('.')+1);
            var key = path+"/"+currentTime+"_"+(idx+1)+"."+fileExt;
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
function getCurrentTime() {
    function pad2(n) {
        return n < 10 ? '0' + n : n
    }
    var now = new Date();
    return now.getFullYear().toString() + pad2(now.getMonth() + 1) + pad2(now.getDate()) + pad2(now.getHours()) + pad2(now.getMinutes()) + pad2(now.getSeconds()) + pad2(now.getMilliseconds());
}