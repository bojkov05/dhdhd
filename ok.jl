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
