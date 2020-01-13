//
//  NewsLineController.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Igor on 10/12/19.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit


class NewsLineController : UITableViewController {
    static var newsCellId = "newsCellId"
    
    var news: [(userName: String, userAvatar: String, date: String, images: [String], text: String, countLike: Int) ] = [
        ("Коля","2","13.01.2019", ["a2","a1"],"Министр экономического развития России Максим Орешкин выступил за переход на расчет в евро и рублях для транзакций с Евросоюзом в нефтегазовой сфере. Такое заявление господин Орешкин сделал газете Financial Times." +
            "«У нас очень хорошая валюта. Она стабильная. Почему бы не использовать ее для глобальных трансакций?» — сказал министр." +
            "По его мнению, переход на оплату в евро и рублях поможет минимизировать потери от санкций США и зависимость от американского доллара." +
             "Ранее председатель Центробанка Эльвира Набиуллина заявила, что доля расчетов в долларах между Россией и европейскими странами будет сокращаться. При этом отказ от американской валюты будет постепенным, уверена госпожа Набиуллина.", 3),
        ("Вася","3", "12.01.2019", ["a1"],"Американские зрители «Джокера» разделились. Одни увидели в ленте левую пропаганду и критику капитализма, другие сочли ее протрамповской и расисткой. «Газета.Ru» рассказывает о том, как фильм, основным посылом которого — хочется верить — является необходимость сострадания и чуткости к окружающим, рассматривают сквозь социально-политическую призму.", 4),
        ("Петя","4", "11.01.2019", ["a4"],"Сборная России забила второй мяч в матче 8-го тура отборочного турнира чемпионата Европы 2020 года с национальной командой Кипра." +
            "Автором результативного удара на 22-й минуте встречи стал полузащитник Магомед Оздоев. Артём Дзюба сделал проникающую передачу в штрафную, Алексей Ионов неудачно прострелил, но Денис Черышев догнал мяч у лицевой и сделал скидку на Оздоева, который пробил под перекладину ворот хозяев." +
            "Матч между сборными Кипра и России прохдит на стадионе «ГСП» в Никосии. «Чемпионат» ведёт текстовую онлайн-трансляцию встречи." +
            "Обслуживает матч бригада арбитров из Сербии во главе с Срджаном Йовановичем. Помогают ему судьи на линиях Урош Стойкович и Милан Михайлович. Роль резервного рефери исполняет Новак Симович.", 7)
    ]

  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsLineController.newsCellId)
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsLineController.newsCellId, for: indexPath) as! NewsCell
        
        cell.userName.text = news[indexPath.row].userName
        cell.userAvatar.nameImage = news[indexPath.row].userAvatar
        cell.date.text = news[indexPath.row].date
        cell.textNews.text  = news[indexPath.row].text
        cell.likedControl.isLiked = true
        cell.imagesNews.image = UIImage(named: news[indexPath.row].images[0])
        return  cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            news.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
