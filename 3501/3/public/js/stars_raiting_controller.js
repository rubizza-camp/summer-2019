class StarsRaitingController
{
    constructor()
    {
        //1. Находим все элементы stars
        this.user_self_CommentRaiting = document.getElementById('user_self_CommentRaiting');
        if (this.user_self_CommentRaiting != undefined)
        {
            this.current_string_raiting = '5';
            this.active_star_icon = 'star';
            this.disable_star_icon = 'star_border';
            this.half_star_icon = 'star_half';
            this.current_state = undefined;
            this.stars = [];
            this.stars.push(document.getElementById('star1'));
            this.stars.push(document.getElementById('star2'));
            this.stars.push(document.getElementById('star3'));
            this.stars.push(document.getElementById('star4'));
            this.stars.push(document.getElementById('star5'));
            this.save_current_state();
            this.user_self_CommentRaiting.value = this.current_string_raiting;
            // Добавляем обработчики
            // Мышь заходит на звезду
            this.stars[0].onmouseenter = ()=>{
                this.save_current_state();
                this.update_temp_stars_state_onover(0);
            };
            this.stars[1].onmouseenter = ()=>{
                this.save_current_state();
                this.update_temp_stars_state_onover(1);
            };
            this.stars[2].onmouseenter = ()=>{
                this.save_current_state();
                this.update_temp_stars_state_onover(2);
            };
            this.stars[3].onmouseenter = ()=>{
                this.save_current_state();
                this.update_temp_stars_state_onover(3);
            };
            this.stars[4].onmouseenter = ()=>{
                this.save_current_state();
                this.update_temp_stars_state_onover(4);
            };

            // Мышь выходит из звезды
            this.stars[0].onmouseleave = ()=>{
                this.load_last_state();
            };
            this.stars[1].onmouseleave = ()=>{
                this.load_last_state();
            };
            this.stars[2].onmouseleave = ()=>{
                this.load_last_state();
            };
            this.stars[3].onmouseleave = ()=>{
                this.load_last_state();
            };
            this.stars[4].onmouseleave = ()=>{
                this.load_last_state();
            };

            // Мышь нажимает на звезду
            this.stars[0].onclick = ()=>{
                this.save_temp_stars_state_onclick(0);
            };
            this.stars[1].onclick = ()=>{
                this.save_temp_stars_state_onclick(1);
            };
            this.stars[2].onclick = ()=>{
                this.save_temp_stars_state_onclick(2);
            };
            this.stars[3].onclick = ()=>{
                this.save_temp_stars_state_onclick(3);
            };
            this.stars[4].onclick = ()=>{
                this.save_temp_stars_state_onclick(4);
            };
        }
        
    }

    compute_current_raiting()
    {
        var new_sum = 0;
        for (var i = 0 ; i < this.current_state.length; i++)
        {
            switch (this.current_state[i])
            {
                case this.active_star_icon:
                    new_sum+=2;
                break;
                case this.disable_star_icon:
                    new_sum+=0;
                break;
                case this.half_star_icon:
                    new_sum+=1;
                break;
            }
        }
        this.current_string_raiting = new_sum.toString();
    }

    save_current_state()
    {
        this.current_state = [];
        for (var i = 0; i < this.stars.length; i++)
        {
            this.current_state.push(this.stars[i].children[0].textContent)
        }
    }
    load_last_state()
    {
        for (var i = 0 ; i < this.stars.length; i++)
        {
            this.stars[i].children[0].textContent = this.current_state[i];
        }
    }
    update_temp_stars_state_onover(current_star_index)
    {
        for (var i = 0 ; i < this.stars.length; i++)
        {
            if (i <= current_star_index)
            {
                this.stars[i].children[0].textContent = this.active_star_icon;
            }
            else
            {
                this.stars[i].children[0].textContent = this.disable_star_icon;
            }
        }
    }
    save_temp_stars_state_onclick(current_star_index)
    {
        switch (this.current_state[current_star_index])
        {
            case this.active_star_icon:
                this.update_temp_stars_state_onclick(current_star_index, this.half_star_icon);
            break;
            case this.disable_star_icon:
                this.update_temp_stars_state_onclick(current_star_index, this.active_star_icon);
            break;
            case this.half_star_icon:
                this.update_temp_stars_state_onclick(current_star_index, this.disable_star_icon);
            break;
        }
        this.save_current_state();
        this.compute_current_raiting();
        this.user_self_CommentRaiting.value = this.current_string_raiting;
    }

    update_temp_stars_state_onclick(current_star_index, template_star_icon)
    {
        for (var i = 0 ; i < this.stars.length; i++)
        {
            if (i < current_star_index)
            {
                this.stars[i].children[0].textContent = this.active_star_icon;
            }
            else
            {
                if (i == current_star_index)
                {
                    this.stars[i].children[0].textContent = template_star_icon;
                }
                else
                {
                    this.stars[i].children[0].textContent = this.disable_star_icon;
                }
            }
        }
    }

    static update_all_users_reiting()
    {
        var raitings = document.getElementsByClassName("users_comment_raiting");
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

starsRaitingController = new StarsRaitingController();
StarsRaitingController.update_all_users_reiting()