class StarsRaitingController
{
    static update_all_users_reiting()
    {
        var raitings = document.getElementsByClassName("stars_raiting");
        for(var i = 0 ; i < raitings.length; i++)
        {
            var cuurent_element = raitings[i];
            var target_sum = parseInt(cuurent_element.getAttribute("value"));
            for (var j = 0; j < cuurent_element.children.length; j++)
            {
                var current_child_star = cuurent_element.children[j];
                switch (true)
                {
                    case target_sum - 2 >= 0:
                        target_sum -= 2;
                        current_child_star.textContent = 'star';
                    break;
                    case target_sum - 1 >= 0:
                        target_sum -= 1;
                        current_child_star.textContent = 'star_half';
                    break;
                    default:
                        target_sum = 0;
                        current_child_star.textContent = 'star_border';
                    break;
                }
            }
        }
    }
}

StarsRaitingController.update_all_users_reiting()