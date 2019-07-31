var user_self_Commentrating;
var current_string_rating;
var active_star_icon;
var disable_star_icon;
var half_star_icon;
var current_state;
var stars;

function initialize_stars_ratings()
{
    user_self_Commentrating = document.getElementById('user_self_Commentrating');
    if (user_self_Commentrating != undefined)
    {
        current_string_rating = '5';
        active_star_icon = 'star';
        disable_star_icon = 'star_border';
        half_star_icon = 'star_half';
        current_state = undefined;
        stars = [];
        stars.push(document.getElementById('star1'));
        stars.push(document.getElementById('star2'));
        stars.push(document.getElementById('star3'));
        stars.push(document.getElementById('star4'));
        stars.push(document.getElementById('star5'));
        save_current_state();
        user_self_Commentrating.value = current_string_rating;
        
        for(var i = 0; i < stars.length; i++)
        {
            stars[i].setAttribute('index',i);
            stars[i].children[0].setAttribute('index',i);
            set_listeners_on_mouse_over(i);
            set_listeners_on_mouse_exit(i);
            set_listeners_on_mouse_click(i);
        }
    }
    
}
function set_listeners_on_mouse_click(index)
{
    stars[index].onclick = function(event){
        index = event.target.getAttribute('index');
        save_temp_stars_state_onclick(index);
    };
}
function set_listeners_on_mouse_exit(index)
{
    stars[index].onmouseleave = function(event){
        index = event.target.getAttribute('index');
        load_last_state();
    };
}
function set_listeners_on_mouse_over(index)
{
    stars[index].onmouseenter = function(event){
        index = event.target.getAttribute('index');
        save_current_state();
        update_temp_stars_state_onover(index);
    };
}

function compute_current_rating()
{
    var new_sum = 0;
    for (var i = 0 ; i < current_state.length; i++)
    {
        switch (current_state[i])
        {
            case active_star_icon:
                new_sum+=2;
            break;
            case disable_star_icon:
                new_sum+=0;
            break;
            case half_star_icon:
                new_sum+=1;
            break;
        }
    }
    current_string_rating = new_sum.toString();
}

function save_current_state()
{
    current_state = [];
    for (var i = 0; i < stars.length; i++)
    {
        current_state.push(stars[i].children[0].textContent);
    }
}
function load_last_state()
{
    for (var i = 0 ; i < stars.length; i++)
    {
        stars[i].children[0].textContent = current_state[i];
    }
}
function update_temp_stars_state_onover(current_star_index)
{
    for (var i = 0 ; i < stars.length; i++)
    {
        if (i <= current_star_index)
        {
            stars[i].children[0].textContent = active_star_icon;
        }
        else
        {
            stars[i].children[0].textContent = disable_star_icon;
        }
    }
}
function save_temp_stars_state_onclick(current_star_index)
{
    switch (current_state[current_star_index])
    {
        case active_star_icon:
            update_temp_stars_state_onclick(current_star_index, half_star_icon);
        break;
        case disable_star_icon:
            update_temp_stars_state_onclick(current_star_index, active_star_icon);
        break;
        case half_star_icon:
            update_temp_stars_state_onclick(current_star_index, disable_star_icon);
        break;
    }
    save_current_state();
    compute_current_rating();
    user_self_Commentrating.value = current_string_rating;
}

function update_temp_stars_state_onclick(current_star_index, template_star_icon)
{
    for (var i = 0 ; i < stars.length; i++)
    {
        if (i < current_star_index)
        {
            stars[i].children[0].textContent = active_star_icon;
        }
        else
        {
            if (i == current_star_index)
            {
                stars[i].children[0].textContent = template_star_icon;
            }
            else
            {
                stars[i].children[0].textContent = disable_star_icon;
            }
        }
    }
}

function update_all_users_reiting()
{
    var ratings = document.getElementsByClassName("users_comment_rating");
    for(var i = 0 ; i < ratings.length; i++)
    {
        var cuurent_element = ratings[i];
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

initialize_stars_ratings();
update_all_users_reiting();