# Исходные данные, представленные в текстовом формате
data = """
Болгар
53, 25, 1б
13200₽ экс
9900₽ пред

Свияжск
54, 34; 45, 21, 2б
54 с теплоходом
31200₽ экс
9600₽ экс
8200₽ пред

Голубые
45, 30
4900₽ экс
2500₽ пред

Йошка
57, 32; 48, 13, 2б
12 по туру
12000₽ экс
23850₽ экс
25900₽ пред

С+Р
46, 33; 33, 13; 41, 19, 5б
79 с теплоходом
28000₽ экс
22800₽ экс
9600₽ экс
18950₽ пред

11:00
51, 32; 50, 27, 4б
2 по туру
7400₽ экс
5000₽ экс
8600₽ пред

Речка 13:30
54, 37; 16, 14
42000₽ экс
2300₽ пред

Голубые 14:15
36, 25, 5б
5000₽ экс
1900₽ пред

13:30
49, 22; 27, 17, 2б
5000₽ экс
5000₽ экс
9100₽ пред

Речка 15:30
44, 29, 2б
25200₽ экс
2400₽ пред

Речка 17:30
58, 47, 1б
34800₽ экс
1700₽ пред

Вечером
50, 41; 52, 30, 5б
3500₽ экс
3500₽ экс
4400₽ пред

Вечером с колесом
51, 28; 48, 34; 20, 9, 7б
7 без колеса
26500₽ экс
24250₽ экс
11100₽ экс
11700₽ пред

стоп
Вильдану 500₽
Исканлеру 1500₽
Вильдан 13000₽
Лена 1500₽
Эдику 4300₽
Ване 4000₽
"""

# Стоимости билетов для каждой экскурсии
ticket_prices = {
    "Болгар": {"full": 3000, "discounted": 2800},
    "Йошка": {"full": 2900, "discounted": 2700},
    "С+Р": {"full": 2400, "discounted": 2200},
    "Свияжск": {"full": 2100, "discounted": 2000},
    "Инополис": {"full": 1500, "discounted": 1400},
    "Голубые": {"full": 1200, "discounted": 1100},
    "Голубые 14:15": {"full": 1200, "discounted": 1100},
    "11:00": {"full": 1200, "discounted": 1100},
    "15:00": {"full": 1200, "discounted": 1100},
    "13:30": {"full": 1200, "discounted": 1100},
    "Речка 13:30": {"full": 1200, "discounted": 1100},
    "Речка 15:30": {"full": 1200, "discounted": 1100},
    "Речка 17:30": {"full": 1200, "discounted": 1100},
    "Вечером": {"full": 1100, "discounted": 1000},
    "Вечером с колесом": {"full": 1500, "discounted": 1400},
}

# Словарь для хранения результатов
results = {}

# Функция для очистки чисел от лишних символов
def parse_value(value):
    """Преобразует строку с деньгами в целое число."""
    return int(value.replace('₽', '').replace(' ', '').strip()) if value else 0

# Парсинг данных
lines = data.strip().split("\n")
i = 0
stop_reached = False
extra_expenses = 0

# Обработка экскурсий
while i < len(lines) and lines[i].strip().lower() != "стоп":
    excursion = lines[i].strip()
    if not excursion:
        i += 1
        continue
    i += 1

    # Переменные для подсчета
    total_participants = 0
    total_discounted = 0
    total_free = 0
    total_tour = 0
    total_boat = 0
    total_without_wheel = 0
    total_with_wheel = 0

    # Парсинг информации по участникам
    while i < len(lines) and ("," in lines[i] or ";" in lines[i]):
        bus_info = lines[i].strip()
        if not bus_info:
            i += 1
            continue
        buses = bus_info.split(';')
        for bus in buses:
            parts = bus.split(',')
            parts = [p.strip() for p in parts]
            
            if len(parts) >= 2:
                try:
                    participants = int(parts[0])
                    discounted = int(parts[1])
                    total_participants += participants
                    total_discounted += discounted
                    for part in parts[2:]:
                        if 'б' in part:
                            total_free += int(part.replace('б', '').strip())
                        if 'опл' in part:
                            total_free += int(part.replace('опл', '').strip())

                except ValueError as e:
                    print(f"Ошибка обработки: {e} для автобуса {bus}")

        i += 1

    # Учет "по туру" как бесплатных участников
    while i < len(lines) and "по туру" in lines[i]:
        if not lines[i].strip():
            i += 1
            continue
        total_tour += int(lines[i].strip().split()[0])
        i += 1

    total_free += total_tour

    # Учет "с теплоходом"
    while i < len(lines) and "с теплоходом" in lines[i]:
        if not lines[i].strip():
            i += 1
            continue
        total_boat += int(lines[i].strip().split()[0])
        i += 1

    # Учет "без колеса"
    while i < len(lines) and "без колеса" in lines[i]:
        if not lines[i].strip():
            i += 1
            continue
        total_without_wheel += int(lines[i].strip().split()[0])
        i += 1

    # Учет "с колесом"
    while i < len(lines) and "с колесом" in lines[i]:
        if not lines[i].strip():
            i += 1
            continue
        total_with_wheel += int(lines[i].strip().split()[0])
        i += 1

    # Расчет дохода
    total_paid = total_participants - total_discounted - total_free
    if total_paid < 0:
        total_paid = 0

    # Используем стоимости по экскурсии с проверкой
    if excursion in ticket_prices:
        price_full = ticket_prices[excursion]['full']
        price_discounted = ticket_prices[excursion]['discounted']

        ticket_income = (total_paid * price_full) + (total_discounted * price_discounted)
        ticket_income += total_boat * 400
        ticket_income -= total_without_wheel * 400
        ticket_income += total_with_wheel * 400
    else:
        print(f"Экскурсия '{excursion}' не найдена в ценах. Установим доход равным 0.")
        ticket_income = 0

    expenses = []
    while i < len(lines) and ("₽ экс" in lines[i] or "₽ пред" in lines[i]):
        expense_value = lines[i].replace("₽ экс", "").replace("₽ пред", "").strip()
        if expense_value:
            expenses.append(parse_value(expense_value))
        i += 1

    total_expenses = sum(expenses)
    net_profit = ticket_income - total_expenses
    results[excursion] = net_profit

# Обработка дополнительных расходов после слова "стоп"
extra_expenses = 0
while i < len(lines):
    line = lines[i].strip()
    if line:
        try:
            name, amount = line.rsplit(' ', 1)
            extra_expenses += parse_value(amount)
        except ValueError:
            print(f"Ошибка при обработке строки: {line}")
    i += 1

final_profit = sum(results.values()) - extra_expenses

for excursion, profit in results.items():
    print(f"Чистая прибыль для {excursion}: {profit}₽")

print(f"Общие дополнительные расходы: {extra_expenses}₽")
print(f"Итоговая прибыль за день (с учетом всех расходов): {final_profit}₽")
