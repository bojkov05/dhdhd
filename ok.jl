using HorizonSideRobots
r=Robot(animate = true)

function long(r,side::Array,mark::Bool)
    c=[]
    for s in side
        while !isborder(r,s)
            move!(r,s)
            if mark
                putmarker!(r)
            end
            push!(c,s)
        end
    end
    return c
end

function rever(side)
    if side == Nord
        return Sud
    end
    if side == Sud
        return Nord
    end
    if side == West
        return Ost
    end
    if side == Ost
        return West
    end
end

function masum(mas1::Array, mas2::Array)
    for s in mas2
        push!(mas1,s)
    end
    return mas1
end

function Home(back::Array)
    back=reverse(back)
    for s in back
        move!(r,rever(s))
    end
end

function diagonal(r,u_r::Bool,u_l::Bool,d_r::Bool,d_l::Bool,mark::Bool)
    c=[]
    if u_r
        while !isborder(r,Ost) || !isborder(r,Nord)
            move!(r,Ost)
            move!(r,Nord)
            push!(c,Ost)
            push!(c,Nord)
            if mark
                putmarker!(r)
            end
        end
    end
    if u_l
        while !isborder(r,West) || !isborder(r,Nord)
            move!(r,West)
            move!(r,Nord)
            push!(c,West)
            push!(c,Nord)
            if mark
                putmarker!(r)
            end
        end
    end
    if d_r
        while !isborder(r,Ost) || !isborder(r,Sud)
            move!(r,Ost)
            move!(r,Sud)
            push!(c,Ost)
            push!(c,Sud)
            if mark
                putmarker!(r)
            end
        end
    end
    if d_l
        while !isborder(r,West) || !isborder(r,Sud)
            move!(r,West)
            move!(r,Sud)
            push!(c,West)
            push!(c,Sud)
            if mark
                putmarker!(r)
            end
        end
    end
    return c
end

function elements(elem,mas::Array)
    k=0
    for i in 1:length(mas)
        if mas[i]==elem
            k+=1
        end
    end
    return k
end

function try_move!(r,side)
    num=0
    f=true
    while isborder(r,side) && f
        if isborder(r,Sud)
            f=false
        else
            move!(r,Sud)
            num+=1
        end
    end
    k=num
    if f
        move!(r,side)
        while isborder(r,Nord)
            move!(r,side)
        end
        for i in 1:num
            move!(r,Nord)
        end
    end
    return f,num>1
end

function task_9(r)
    side=Ost
    local i=0
    local j=0
    putmarker!(r)
    while !isborder(r,side)
        move!(r,side)
        j+=1
        if mod(j,2)==0
            putmarker!(r)
        end
    end
    while !isborder(r,Nord)
        move!(r,Nord)
        i+=1
        if mod(i,2)!=0
            side=West
        else
            side=Ost
        end
        local j=0
        putmarker!(r)
        while !isborder(r,side)
            move!(r,side)
            j+=1
            if mod(j,2)==0
                putmarker!(r)
            end
        end
    end
end

function task_19(r,side)
    if isborder(r,side)
        return 0
    else
        move!(r,side)
        return task_19(r,side)
    end
end

function task_20(r,side,steps)
    if isborder(r,side)
        putmarker!(r)
        num_steps(r,rever(side),steps)
        return 1
    else
        move!(r,side)
        return task_20(r,side,steps+1)
    end
end

function task_21(r,side,steps)
    side1=Nord
    if side==Sud || side==Nord
        side1=West
    end
    if isborder(r,side)
        move!(r,side1)
        return task_21(r,side,steps+1)
    elseif steps>0
        num_steps(r,side1,steps)
        return 1
    else
        move!(r,side)
        return 1
    end
end

function task_22(r,side,steps,f)
    if !f
        if isborder(r,side)
            f=true
            return task_22(r,rever(side),steps*2,f)
        else
            return task_22(r,side,steps+1,f)
        end
    else
        if isborder(r,side) && steps == 0
            return true
        elseif isborder(r,side) && steps!=0
            return false
        elseif steps==0
            return true
        else
            move!(r,side)
            return task_22(r,side,steps-1,f)
        end
    end
end
