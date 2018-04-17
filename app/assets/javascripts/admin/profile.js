var vHeight = 202,
image = null,
croppie = null;

function initCroppie() {
    var avatar = $('#avatar');
    var width = $(".avatar-wrapper").width(),
    bWidth = width * 82/100,
    vWidth = bWidth * 53/100;

    if (vWidth > 160) {
        vWidth = 160;
    }

    avatar.croppie('destroy');
    croppie = avatar.croppie({
        viewport: {
            width: vWidth,
            height: vWidth,
            type: 'circle'
        },
        boundary: {
            width: bWidth,
            height: vHeight
        }
    });
    if (image) {
        croppie.croppie('bind', {
            url: image
        });
    }
};

var timer;

$(window).resize(function () {
    if (croppie) {
        timer && clearTimeout(timer);
        timer = setTimeout(initCroppie, 100);
    }
});

function readFile(input) {
    if (input.files && input.files[0]) {
        var file_type = input.files[0].type.split('/')
        if(file_type[0] == "image"){
            var reader = new FileReader();
            reader.onload = function (e) {
                image = e.target.result;
                hideCurrentImage();
                initCroppie();
                hideSpinner();
            }
            closeChooseModal();
            makeCurrentImageInvisible();
            hideChangePictureButton();
            showAvatarControlButtons();
            showSpinner();
            reader.readAsDataURL(input.files[0]);
        }
        else{
            closeChooseModal();
            $('#avatar').croppie('destroy');
            $("#avatar").removeClass('croppie-container');
            hideAvatarControlButtons();
            showChangePictureButton();
            makeCurrentImageVisible();
            showCurrentImage();
            alert("Please select a valid image format.");
        }
    }
    else {
        alert("Sorry - you're browser doesn't support the FileReader API");
    }
}

$("#cancel-upload").click(function () {
    croppie = null;
    $('#avatar').croppie('destroy');
    $("#avatar").removeClass('croppie-container');
    hideAvatarControlButtons();
    showChangePictureButton();
    makeCurrentImageVisible();
    showCurrentImage();
});

function showAvatarControlButtons() {
    $(".avatar-controls").show();
}

function hideAvatarControlButtons() {
    $(".avatar-controls").hide();
}

function showChangePictureButton() {
    $("#change-picture").show();
}

function hideChangePictureButton() {
    $("#change-picture").hide();
}

function closeChooseModal() {
    $("#choose-modal").modal('hide');
}

function hideCurrentImage() {
    $(".avatar-wrapper .avatar-preview").hide();
}

function showCurrentImage() {
    $(".avatar-wrapper .avatar-preview").show();
}

function makeCurrentImageInvisible() {
    $(".avatar-wrapper .avatar-preview").css({visibility: 'hidden'});
}

function makeCurrentImageVisible() {
    $(".avatar-wrapper .avatar-preview").css({visibility: 'visible'});
}

function showSpinner() {
    $(".avatar-wrapper .spinner").css({opacity: 1});
}

function hideSpinner() {
    $(".avatar-wrapper .spinner").css({opacity: 0});
}
$('#avatar-upload').on('change', function () { readFile(this); });
$('#save-photo').on('click', function (ev) {
    croppie.croppie('result', {
        type: 'canvas',
        size: 'original'
    }).then(function (resp) {
        $('#imagebase64').val(resp);
        $('#avatar-form').submit();
        $(".avatar-controls .btn").attr('disabled', 'disabled');
        $(".avatar-controls .btn").text("Saving...");
    });
    return false;
});
/******************************************************/