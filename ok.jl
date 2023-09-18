using HorizonSideRobots
r=Robot(animate = true)
back=[]
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

back=long(r,[Nord,Ost],true)

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

function Home(back::Array)
    back=reverse(back)
    for s in back
        print(rever(s))
        move!(r,rever(s))
    end
end

Home(back)
