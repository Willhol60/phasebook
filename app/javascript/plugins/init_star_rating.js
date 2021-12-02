import "jquery-bar-rating";

const initStarRating = () => {
  $('#reading_user_rating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
