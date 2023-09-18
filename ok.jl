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
