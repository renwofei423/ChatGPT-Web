const URL_REGEX = /^(https?:\/\/)?((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|((\d{1,3}\.){3}\d{1,3}))(:\d+)?(\/[-a-z\d%_.~+]*)*(\?[;&a-z\d%_.~+=-]*)?([-a-z\d_]*)?$/i;

function isValidUrl(url: string) {
  return URL_REGEX.test(url);
}

export default {
  isValidUrl,
};